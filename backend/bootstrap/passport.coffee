passport        = require 'passport'
BearerStrategy  = require('passport-http-bearer').Strategy

module.exports = (passport) ->

  passport.serializeUser (user, done) ->
    done null, user.id

  passport.deserializeUser (id, done) ->
    orm.Users.find({where: {id: id}}).then (user) ->
      if not user
        done(null, false)
      done(null, user)
    , (err) ->
      if err
        done(err, null)

  passport.use(new BearerStrategy(
    (token, done) ->
      orm.Users.findOne({ where: {token: token}}).then (user) ->
        if not user
          done(null, false)
        done(null, user)
      , (err) ->
        if err
          done(err)
  ))
