const express = require("express");
const path = require("path");
const multer = require("multer");
const pool = require("../config");
const { isLoggedIn } = require("../middlewares");
const router = express.Router()



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
  "/:chatId/messages", upload.single('message_image'),isLoggedIn,
  async function (req, res, next) {

    const message = req.body.message;
    
    const conn = await pool.getConnection();
    await conn.beginTransaction();

    try {
        
      let results = await conn.query(
        "INSERT INTO messages(chat_id, message, m_image, m_by_id, m_timestamp) VALUES(?,?,?,?,CURRENT_TIMESTAMP)",
        [req.params.chatId, message, req.user.picture, req.user.id]
      );

      await conn.commit();
    
      res.redirect("/chats/" + req.params.chatId);
    } catch (err) {
      await conn.rollback();
      next(err);
    } finally {
      console.log("finally");
      conn.release();
    }
  }
);




exports.router = router;