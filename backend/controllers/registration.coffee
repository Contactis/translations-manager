module.exports = ->

  app.post '/api/register', (req, res) ->



    orm.Users.findAll
      where:
        email: req.body.email
    .then (result) ->
      if result.length == 0
        res.json
          canCreate: true

      else
        res.json
          canCreate: false

