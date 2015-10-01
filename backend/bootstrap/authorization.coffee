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
          ).then (user) ->
            res.json user.get()
        else
          res.status 401
          res.json 'not authorised'
    else
      res.status 401
      res.json 'not authorised'
