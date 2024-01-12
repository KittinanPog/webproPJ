const express = require("express");
const pool = require("../config");

router = express.Router();

router.get("/", async function (req, res, next) {
  try {
    const [rows, fields] = await pool.query(
      `SELECT * FROM blogs JOIN items on blogs.id=items.blog_id`
    );
    console.log(rows)
    return res.json(rows);
    
  } catch (err) {
    return next(err)
  }
});

exports.router = router;
