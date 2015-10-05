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




isLoggedIn = (request, response, next) ->
  # if user is authenticated in the session, then move on
  if request.isAuthenticated() then return next()

  # if isn't authenticated then redirect
  response.redirect('/login')
