const express = require("express")
var cors = require('cors')
const path = require("path")

const app = express();
const { logger } = require('./middlewares')
app.use(logger)
app.use(cors())
// Statics
app.use(express.static('static'))

app.use(express.json()) // for parsing application/json
app.use(express.urlencoded({ extended: true })) // for parsing application/x-www-form-urlencoded

// routers
const indexRouter = require('./routes/index')
const blogRouter = require('./routes/blog')
const commentRouter = require('./routes/comment')
const itemRouter = require('./routes/item')
const userRouter = require('./routes/user')
const chatRouter = require('./routes/chat')
const messageRouter = require('./routes/message')
const inventoryRouter = require('./routes/inventory')

app.use(indexRouter.router)
app.use(blogRouter.router)
app.use(commentRouter.router)
app.use(itemRouter.router)
app.use(userRouter.router)
app.use(chatRouter.router)
app.use(messageRouter.router)
app.use(inventoryRouter.router)
app.listen(3000, () => {
  console.log(`Example app listening at http://localhost:3000`)
})