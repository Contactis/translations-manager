jwt = require 'jwt-simple'
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

  app.post '/api/signin', (request, response, done) ->
    response.json {message: "Not implemented yet"}
    email     = request.body.email or  ''
    password  = request.body.password or ''
    firstName = request.body.firstName or ''
    lastName  = request.body.lastName or ''


  app.post '/api/login', (request, response, done) ->
    email     = request.body.email or ''
    password  = request.body.password or ''

    if email == '' or password == ''
      response.status 401
      response.json {
        status: 401
        message: "Invalid credentials"
      }
      return

    orm.Users.findOne({where: {email: email, password: password}}).then (user) ->
      if not user
        done(null, false)

      # user exsist then
      mu = createNewToken(user.id)
      console.log "mu>>", mu

    , (err) ->
      if err
        done(err)

  app.get '/api/profile', passport.authenticate('bearer', {session: false}), (request, response) ->
    response.json {message: "BAM! you are loggend in!"}



createNewToken = (userId) ->
  return "hahaha" + userId



isLoggedIn = (request, response, next) ->
  # if user is authenticated in the session, then move on
  if request.isAuthenticated() then return next()

  # if isn't authenticated then redirect
  response.redirect('/login')
