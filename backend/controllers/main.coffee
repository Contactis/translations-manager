Sequelize = require 'sequelize'
sequelize = new Sequelize(dbConfig.database, dbConfig.username, dbConfig.password, {
  host:     dbConfig.host
  dialect:  dbConfig.dialect
  storage:  dbConfig.storage
})

module.exports = (app, passport) ->

  app.get '/api', (request, response) ->
    response.json {message: "Welcome to translation manager API at " + config.host + ':' + config.backendPort + '/api'}

  app.get '/api/login', (request, response, next) ->
    response.json { "username": "John Doe" }

  app.get '/api/profile',

  app.post '/api/signin', passport.authenticate('', {
    successRedirect: '/dashboard'
    failureRedirect: '/signup',

  })


isLoggedIn = (request, response, next) ->
  # if user is authenticated in the session, then move on
  if request.isAuthenticated() then return next()

  # if isn't authenticated then redirect
  response.redirect('/login')
