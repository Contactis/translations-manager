express = require 'express'
GLOBAL.app = express()

chalk = require 'chalk'

app.use express.static 'public'

GLOBAL.server = app.listen 3000, ->
  host = server.address().address
  port = server.address().port
  console.log chalk.green 'Translation Manager listening at http://%s:%s', host, port