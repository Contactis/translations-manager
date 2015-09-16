express = require 'express'
moment  = require 'moment'

GLOBAL.app = express()

chalk = require 'chalk'

app.use express.static 'public'

GLOBAL.server = app.listen config.backendPort, ->

  console.log "[#{chalk.gray moment().format 'HH:mm:ss'}]
#{chalk.green '[express] Translation Manager backend is running on port '+ config.backendPort}"