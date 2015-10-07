authService = require '../services/authorisationService'
createNewToken = authService.createNewToken

module.exports = ->

  app.all '/api/*', (req, res, next) ->

    req.token = req.headers['authorization']
    next()



  app.get '/api/profile', (req, res) ->

    if req.token

      orm.Sessions.findOne(
        where:
          token: req.token
      ).then (session) ->

        if session

          orm.Users.findOne(
            where:
              id: session.userId
            attributes: {
              exclude: ['password']
            }
          ).then (user) ->
            res.json user.get()
        else
          res.status 401
          res.json 'not authorised'
    else
      res.status 401
      res.json 'not authorised'


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

    orm.Users.findOne({where: {email: email}}).then (user) ->

      if not user || !user.validPassword(password)

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

