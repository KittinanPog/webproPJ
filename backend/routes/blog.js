const express = require("express")
const path = require("path")
const pool = require("../config")
const { isLoggedIn } = require("../middlewares");
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



router.post("/blogs", upload.single('item_image'), isLoggedIn, async function (req, res, next) {
  const file = req.file;
    if (!file) {
      const error = new Error("Please upload a file");
      error.httpStatusCode = 400;
      return res.status(400).json(error.message)
    }

    const name = req.body.item_name;
    const desc = req.body.item_desc;
    const status = "On Going";
    const title = req.body.title;
    const description = req.body.description;
    
    

    const conn = await pool.getConnection()
    // Begin transaction
    await conn.beginTransaction();

    try {
      
      let blog = await conn.query(
        "INSERT INTO blogs(title, description, create_by_id) VALUES(?, ?,?);",
        [title, description, req.user.id]
      )
      const blogId = blog[0].insertId;
      let item = await conn.query(
        "INSERT INTO items(item_name, item_desc, item_image, status, blog_id, own_by_id) VALUES(?, ?, ?, ?, ?,?);",
        [name, desc, file.path.substr(6), status, blogId, req.user.id]
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

router.get("/blogs/:id",isLoggedIn, function (req, res, next) {
  const promise1 = pool.query("SELECT * FROM blogs JOIN items on blogs.id=items.blog_id where id=?", [req.params.id]);
  const promise2 = pool.query("SELECT * FROM comments JOIN users on users.id=comments.comment_by_id where comments.blog_id=?", [req.params.id]);
 

  Promise.all([promise1,
    promise2,

  ])
    .then((results) => {
      const blogs = results[0];
      const comments = results[1];

      // const images = results[2];
      res.json({
        blog: blogs[0][0],
        // images: images[0],
        comments: comments[0],

        error: null,
      });
      
    })
    .catch((err) => {
      return next(err);
    });
});

router.put(
  "/blogs/:id", isLoggedIn,
  upload.single("myImage"),
  async function (req, res, next) {
    const conn = await pool.getConnection();
    await conn.beginTransaction();

    try {
      const file = req.file;

      if (file) {
        await conn.query("UPDATE images SET file_path=? WHERE id=?", [
          file.path,
          req.params.id,
        ]);
      }

      await conn.query(
        "UPDATE blogs SET title=?,content=?, pinned=?, blogs.like=?, create_by_id=? WHERE id=?",
        [
          req.body.title,
          req.body.content,
          req.body.pinned,
          req.body.like,
          null,
          req.params.id,
        ]
      );
      conn.commit();
      res.json({ message: "Update Blog id " + req.params.id + " Complete" });
    } catch (error) {
      await conn.rollback();
      return next(error);
    } finally {
      console.log("finally");
      conn.release();
    }
  }
);

router.delete("/blogs/:id", isLoggedIn, async function (req, res) {
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
