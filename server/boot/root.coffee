path          = require 'path'
express       = require 'express'
bodyParser    = require 'body-parser'
cookieParser  = require 'cookie-parser'

module.exports = (server) ->

  server.use express.static 'public'

  server.get '/*', (req, res, next) ->
    if req.originalUrl.includes('/api')
      return next()
    res.sendFile path.resolve __dirname + '/../../public/index.html'


  return
