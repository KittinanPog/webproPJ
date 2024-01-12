const express = require("express")
const path = require("path")
const pool = require("../config")

router = express.Router()

// Require multer for file upload
const multer = require('multer')
// SET STORAGE
var storage = multer.diskStorage({
  destination: function (req, file, callback) {
    callback(null, './static/uploads')
  },
  filename: function (req, file, callback) {
    callback(null, file.fieldname + '-' + Date.now() + path.extname(file.originalname))
  }
})
const upload = multer({ storage: storage })



router.post("/items", upload.single('item_image'), async function (req, res, next) {
  const file = req.file;
    if (!file) {
      const error = new Error("Please upload a file");
      error.httpStatusCode = 400;
      return res.status(400).json(error.message)
    }

    const name = req.body.item_name;
    const desc = req.body.item_desc;
    const status = "On Going";

    const conn = await pool.getConnection()
    // Begin transaction
    await conn.beginTransaction();

    try {
      
      await conn.query(
        "INSERT INTO items(item_name, item_desc, item_image, status) VALUES(?, ?, ?, ?);",
        [name, desc, file.path.substr(6), status]
      )
      
      await conn.commit()
      res.json("success!")
    } catch (err) {
      await conn.rollback();
      res.status(400).json(err)
    } finally {
      console.log('finally')
      conn.release();
    }
    
});

router.get("/blogs/:id", function (req, res, next) {
  const promise1 = pool.query("SELECT * FROM blogs WHERE id=?", [req.params.id]);
  // const promise2 = pool.query("SELECT * FROM comments LEFT OUTER JOIN images ON (comments.id = images.comment_id) WHERE comments.blog_id=?", [req.params.id]);
  // const promise3 = pool.query("SELECT * FROM images WHERE blog_id=? AND comment_id IS NULL", [req.params.id])

  Promise.all([promise1
    // , promise2, promise3
  ])
    .then((results) => {
      const blogs = results[0];
      // const comments = results[1];
      // const images = results[2];
      res.json({
        blog: blogs[0][0],
        // images: images[0],
        // comments: comments[0],
        error: null,
      });
    })
    .catch((err) => {
      return next(err);
    });
});

router.put(
  "/items/:blogId/:chatId/:buyId/:itemId",
  upload.single("myImage"),
  async function (req, res, next) {
    const status = "Sold";
    const conn = await pool.getConnection();
    await conn.beginTransaction();

    try {
      await conn.query(
        "UPDATE items SET own_by_id=?,status=? WHERE item_id=?",
        [
          req.params.buyId,
          status,
          req.params.itemId,
        ]
        
      );
      await conn.query(
        "DELETE FROM chats WHERE chat_id=?",
        [
          req.params.chatId,
        ]
      )
      await conn.query(
        "DELETE FROM blogs WHERE id=?",
        [
          req.params.blogId,
        ]
      )
      conn.commit();
      res.json({ message: " complete" });
    } catch (error) {
      await conn.rollback();
      return next(error);
    } finally {
      console.log("finally");
      conn.release();
    }
  }
);

router.delete("/blogs/:id", async function (req, res) {
  const conn = await pool.getConnection();
  await conn.beginTransaction();

  try {
    // check blog has comment?
    let comments = await conn.query("SELECT * FROM comments WHERE blog_id=?", [
      req.params.id,
    ]);

    if (comments[0].length > 0) {
      res
        .status(409)
        .json({ message: "Can't Delete because this blog has comment!!!" });
    } else {
      await conn.query("DELETE FROM blogs WHERE id=?;", [req.params.id]); // delete blog
      await conn.query("DELETE FROM images WHERE blog_id=?;", [req.params.id]); // delete image
      await conn.commit();
      res.json({ message: "Delete Blog id " + req.params.id + " complete" });
    }
  } catch (error) {
    await conn.rollback();
    next(error);
  } finally {
    console.log("finally");
    conn.release();
  }
});

exports.router = router;
