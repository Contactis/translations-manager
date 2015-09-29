module.exports = ->

  app.all '/api/*', (req, res, next) ->
    console.log 'auth token', req.headers['authorization']
    req.token = req.headers['authorization']
    next()



  app.get '/api/profile', (req, res) ->


    orm.Sessions.findOne({token: req.token}).then (session) ->
      session = session.get()
      if session
        orm.Users.findOne({id: session.id}).then (user) ->
          res.json user.get()
