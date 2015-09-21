passport      = require 'passport'
LocalStrategy = require('passport-local').Strategy
BearerStrategy = require('passport-http-bearer').Strategy

module.exports = (passport) ->

  passport.serializeUser (user, done) ->
    done null, user.id

  passport.deserializeUser (id, done) ->
    orm.Users.find({where: {id: id}}).then (user) ->
      done(null, user)
    , (err) ->
      done(err, null)

  passport.use(new BearerStrategy(
    (token, done) ->
      orm.Users.findOne({ where: {token: token}}).then (user) ->
        if not user
          done(null, false)
      , (err) ->
        if err then return done(err)
  ))


  # passport.use(new LocalStrategy(
  #   (email, password, done) ->
  #     orm.Users.findOne({ where: {email: email}}).then (user) ->
  #       if not user
  #         done(null, false, request.json({message: 'User unknown.'}))
  #       else if password isnt user.password
  #         newUser = new User()
  #         newUser.email = email
  #         newUser.password = newUser.generateHash(password)

  #         newUser.save (err) ->
  #           if err
  #             throw err
  #           return done(null, newUser)

  # ))

  # passport.use('local-signup', new LocalStrategy {
  #   usernameField:      'email'
  #   passwordField:      'password'
  #   passReqToCallback:  true # allows us to pass back the entire request to the callback
  # }, (request, email, password, done) ->

  #   # asynchronous
  #   process.nextTick () ->
  #     Users.findOne({ where: {email: email}}).then (user) ->

  #       if user
  #         done(null, false, request.json {message: 'That email is already taken.'})
  #       else
  #         newUser = new User()
  #         newUser.email = email
  #         newUser.password = newUser.generateHash(password)

  #         newUser.save (err) ->
  #           if err
  #             throw err
  #           return done(null, newUser)

  # )
