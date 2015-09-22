Sequelize = require 'sequelize'
sequelize = new Sequelize(dbConfig.database, dbConfig.username, dbConfig.password, {
  host:     dbConfig.host
  dialect:  dbConfig.dialect
  storage:  dbConfig.storage
})

module.exports = (app, passport) ->

  app.get '/api', (request, response) ->
    response.json {message: "Welcome to translation manager API at " + config.host + ':' + config.backendPort + '/api'}

  app.get '/api/ErrorExample', (request, response, next) ->
    next(new Error 'Random error')

  app.get '/api/login', (request, response, next) ->
    response.json {message: "Not implemented yet"}

  app.get '/api/profile', passport.authenticate('bearer', {session: false}), (request, response) ->
    response.json {message: "BAM! you are loggend in!"}

  app.post '/api/signin', () ->
    response.json {message: "Not implemented yet"}


isLoggedIn = (request, response, next) ->
  # if user is authenticated in the session, then move on
  if request.isAuthenticated() then return next()

  # if isn't authenticated then redirect
  response.redirect('/login')
