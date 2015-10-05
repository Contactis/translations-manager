authService = require '../services/authorisationService'
createNewToken = authService.createNewToken

module.exports = ->
  app.post '/api/register', (req, res) ->
    orm.Users.findAll
      where:
        email: req.body.email
    .then (result) ->
      if result.length == 0
        orm.Users.create
          email: req.body.email
          firstName: req.body.firstName
          lastName: req.body.lastName
          role: 'user'
          password: req.body.password
        .then (newUser) ->

          res.status 201
          res.json
            created: true
            token: createNewToken(newUser.id)

      else
        res.status 400
        res.json
          created:  false
          reason:   'email taken'

