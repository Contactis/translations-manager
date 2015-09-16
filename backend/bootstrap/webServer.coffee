express     = require 'express'
GLOBAL.app  = express()
moment      = require 'moment'
chalk       = require 'chalk'
bodyParser  = require 'body-parser'


# configure app to use bodyParser()
# this will let us get the data from a POST
app.use bodyParser.urlencoded(extended: true)
app.use bodyParser.json()
app.use express.static 'public'


# app.get '/api', (req, res) ->
#   res.send('adfsadfsdf')

# app.get '/api', (request, response) ->
#   response.json { message: 'Inistalize awesome!' }


# ROUTES FOR OUR API
# =============================================================================
router = express.Router()

router.get '/', (request, resource) ->
  resource.json {messages: 'Translation API is running'}
  return


# REGISTER OUR ROUTES -------------------------------
# all of our routes will be prefixed with /api
app.use '/api', router

GLOBAL.server = app.listen config.backendPort, ->

  console.log "[#{chalk.gray moment().format 'HH:mm:ss'}]
#{chalk.green '[express] Translation Manager backend is running at'} #{chalk.blue 'http://' + config.host + ':' + config.backendPort + '/'}"

