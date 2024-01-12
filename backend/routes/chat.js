const express = require("express");
const path = require("path");
const router = express.Router()
const multer = require("multer");
const pool = require("../config");
const { isLoggedIn } = require("../middlewares");


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

//create chat
router.post("/:blogId/chats/:userId/:toId", upload.single('chat_image'), async function (req, res, next) {
  const status = "on_going";

  const conn = await pool.getConnection()
  // Begin transaction
  await conn.beginTransaction();

  try {


    let chat = await conn.query(
      "INSERT INTO chats(form_blog_id,chat_by_id, chat_to_id, chat_status) VALUES(?, ?, ?, ?);",
      [req.params.blogId, req.params.userId, req.params.toId, status]
    )


    await conn.commit()

    res.json("success!")
  } catch (err) {
    await conn.rollback();
    next(err);
  } finally {
    console.log('finally')
    conn.release();
  }
});

router.get("/chat", isLoggedIn, async function (req, res, next) {
  const promise1 = pool.query(`SELECT * FROM chats JOIN users on chats.chat_to_id=users.id where chats.chat_by_id=?`,
    [req.user.id]);
  const promise2 = pool.query(`SELECT * FROM chats JOIN users on chats.chat_by_id=users.id where chats.chat_to_id=?`,
    [req.user.id]);


  Promise.all([promise1,
    promise2,

  ])
    .then((results) => {
      const chatsby = results[0];
      const chatsto = results[1];

      // const images = results[2];
      res.json({
        chatsby: chatsby[0],
        chatsto: chatsto[0],

        error: null,
      });

    })
    .catch((err) => {
      return next(err);
    });
});

router.get("/chats/:blogId/:chatId", isLoggedIn, function (req, res, next) {
  const promise1 = pool.query("SELECT * FROM chats where chat_id=?", [req.params.chatId]);
  const promise2 = pool.query("SELECT * FROM messages JOIN users on messages.m_by_id=users.id JOIN chats on chats.chat_by_id=messages.m_by_id where messages.chat_id=?", [req.params.chatId]);
  const promise3 = pool.query("SELECT * FROM messages JOIN users on messages.m_by_id=users.id JOIN chats on chats.chat_to_id=messages.m_by_id where messages.chat_id=?", [req.params.chatId]);
  const promise4 = pool.query("SELECT * FROM blogs JOIN items on blogs.id=items.blog_id where id=?", [req.params.blogId]);
  Promise.all([promise1,promise2,promise3, promise4
  ])
    .then((results) => {
      const chat = results[0];
      const messagesby = results[1];
      const messagesto = results[2];
      const blogs = results[3];
      // const images = results[2];
      res.json({
        chat: chat[0][0],
        // images: images[0],
        messageby: messagesby[0],
        messageto: messagesto[0],
        blog: blogs[0][0],
        error: null,
      });

    })
    .catch((err) => {
      return next(err);
    });
});


exports.router = router;