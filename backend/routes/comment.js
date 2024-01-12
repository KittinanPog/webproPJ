const express = require("express");
const path = require("path");
const router = express.Router()
const multer = require("multer");
const pool = require("../config");
const { isLoggedIn } = require("../middlewares");

const commentOwner = async (req, res, next) => {
  if (req.user.role === "admin") {
    return next();
  }

  const [[comment]] = await pool.query("SELECT * FROM comments WHERE id=?", [
    req.params.commentId,
  ]);

  if (comment.comment_by_id !== req.user.id) {
    return res
      .status(403)
      .send("You do not have permission to perform this action");
  }

  next();
};
var storage = multer.diskStorage({
  destination: function (req, file, callback) {
    callback(null, "./static/uploads"); // path to save file
  },
  filename: function (req, file, callback) {
    // set file name
    callback(
      null,
      file.fieldname + "-" + Date.now() + path.extname(file.originalname)
    );
  },
});

const upload = multer({ storage: storage });

// Get comment
router.get("/:blogId/comments", function (req, res, next) {

});

// Create new comment
router.post(
  "/:blogId/comments", upload.single('comment_image'),isLoggedIn,
  async function (req, res, next) {

    const content = req.body.content;
    
    const conn = await pool.getConnection();
    await conn.beginTransaction();

    try {
      let results = await conn.query(
        "INSERT INTO comments(blog_id,content, image, comment_by_id,comment_date) VALUES(?,?,?,?,CURRENT_TIMESTAMP)",
        [req.params.blogId, content, req.user.picture, req.user.id]
      );

      await conn.commit();
    
      res.redirect("/blogs/" + req.params.blogId);
    } catch (err) {
      await conn.rollback();
      next(err);
    } finally {
      console.log("finally");
      conn.release();
    }
  }
);

// Update comment
router.put('/comments/:commentId', upload.single('comment_image'),isLoggedIn,commentOwner,
  async function (req, res, next) {
  try {
      const [rows1, fields1] = await pool.query(
          'UPDATE comments SET content=? WHERE comment_id=?', [req.body.content, req.params.commentId]
      )
      console.log(rows1)
      res.json({ comment: req.body.content })
  } catch (error) {
      res.status(500).json(error)
  }
});

// Delete comment
router.delete("/comments/:commentId",isLoggedIn,
 async function (req, res, next) {
  try {
    const [rows, fields] = await pool.query(
      "DELETE FROM comments WHERE id =?",
      [req.params.commentId]
    );

    return res.json({
      message: "Comment ID" + req.params.commentId + "is deleted.",
    });
  } catch (err) {
    return next(err);
  }
});



exports.router = router;