express     = require 'express'
GLOBAL.app  = express()
moment      = require 'moment'
chalk       = require 'chalk'
bodyParser  = require 'body-parser'
path        = require 'path'
epilogue    = require 'epilogue'
http        = require 'http'


# configure app to use bodyParser()
# this will let us get the data from a POST
app.use bodyParser.urlencoded(extended: true)
app.use bodyParser.json()
app.use express.static 'public'

epilogue.initialize
  app:        app
  sequelize:  orm.sequelize
  base:       '/api'

require('../bootstrap/endpoints')(epilogue)


app.get '/*', (req, res) ->
  res.sendFile path.resolve __dirname + '/../../public/index.html'

GLOBAL.server = app.listen config.backendPort, ->

  console.log "[#{chalk.gray moment().format 'HH:mm:ss'}]
#{chalk.green '[express] Translation Manager backend is running at'}
#{chalk.blue 'http://' + config.host + ':' + config.backendPort + '/'}"

