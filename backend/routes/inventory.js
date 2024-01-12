const express = require("express")
const path = require("path")
const pool = require("../config")

router = express.Router();
router.get("/inventory", function (req, res, next) {
    // const promise1 = pool.query("SELECT item_id, item_name, item_desc, status FROM items JOIN users on items.id=users.id where items.status=?", ['Sell']);
    const promise1 = pool.query("SELECT item_id, item_name, item_desc, item_image, own_by_id ,status FROM items where items.status=?", ['Sold']);
    
  
    Promise.all([promise1
    ])
      .then((results) => {
        const inventorys = results[0];
        // const images = results[2];
        res.json({
          inventory: inventorys[0],
          // images: images[0],
          error: null,
        });
        
      })
      .catch((err) => {
        return next(err);
      });
  });

exports.router = router;
