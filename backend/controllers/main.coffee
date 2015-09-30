jwt     = require 'jwt-simple'
moment  = require 'moment'

module.exports = (app, passport) ->

  app.get '/api', (request, response) ->
    response.json
      message: "Welcome to translation manager API at " + config.host + ':' + config.backendPort + '/api'

  app.get '/api/routes', (req, res) ->

    routes = app._router.stack

    paths = []

    JSON.parse(JSON.stringify(routes)).forEach (val, index) ->
      if typeof val.route != 'undefined'
        if val.route.path != '/api/*'
          paths.push
            path:     val.route.path
            methods:  val.route.methods

    res.json paths


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

        response.status 401
        response.json
          status: 401
          message: "Invalid credentials"

        return

      else # user exsist then

        response.status 200
        response.json
          token: createNewToken(user.id)

        return


    , (err) ->
      if err
        done(err)

#  app.get '/api/profile', passport.authenticate('bearer', {session: false}), (request, response) ->
#    response.json {message: "BAM! you are loggend in!"}



createNewToken = (userId) ->

  token = jwt.encode(userId, Math.random().toString(), 'HS512')

  orm.Sessions.create
    userId: userId
    token: token
    expiryAt: moment().add(7, 'days').format()


  return token




isLoggedIn = (request, response, next) ->
  # if user is authenticated in the session, then move on
  if request.isAuthenticated() then return next()

  # if isn't authenticated then redirect
  response.redirect('/login')
