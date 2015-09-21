express       = require 'express'
GLOBAL.app    = express()
port          = process.env.PORT || config.backendPort
passport      = require 'passport'
localStrategy = require('passport-local').Strategy
session       = require 'express-session'
moment        = require 'moment'
chalk         = require 'chalk'
bodyParser    = require 'body-parser'
cookieParser  = require 'cookie-parser'
morgan        = require 'morgan'
path          = require 'path'
epilogue      = require 'epilogue'
http          = require 'http'


app.use morgan('dev')
app.use cookieParser()
app.use bodyParser.json()                       # configure app to use bodyParser()
app.use bodyParser.urlencoded(extended: true)   # this will let us get the data from a POST

app.use express.static 'public'
app.use session { secret: config.secret }
app.use passport.initialize()
app.use passport.session()


# Epilogue setup
epilogue.initialize
  app:        app
  sequelize:  orm.sequelize
  base:       '/api'

require('../bootstrap/endpoints')(epilogue)

# Routes: customs, indexes, ...
require('../controllers/main')(app, passport)

require('../bootstrap/passport')(passport)


# AngularJS
app.get '/*', (req, res) ->
  res.sendFile path.resolve __dirname + '/../../public/index.html'

GLOBAL.server = app.listen port, ->

  console.log "[#{chalk.gray moment().format 'HH:mm:ss'}]
#{chalk.green '[express] Translation Manager backend is running at'}
#{chalk.blue 'http://' + config.host + ':' + config.backendPort + '/'}"

