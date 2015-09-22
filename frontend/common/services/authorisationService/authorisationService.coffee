angular.module 'authorisationService', ['restangular']

.service 'authorisation', ($q, Restangular) ->


  login = (email, password) ->

    _deferred = $q.defer()

    Restangular.all('login').post(
      email:          email
      password:       password
    ).then (response) ->

      _deferred.resolve response

    return _deferred.promise



  register = (email, password, repeatPassword, username) ->

    _deferred = $q.defer()

    Restangular.all('register').post(
      email:          email
      password:       password
      repeatPassword: repeatPassword
      username:       username
    ).then (response) ->

      _deferred.resolve response


    return _deferred.promise



  api =
    login:    login
    register: register



  return api
