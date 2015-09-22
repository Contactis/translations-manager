angular.module 'authorisationService', ['restangular']

.service 'authorisation', ($q, Restangular) ->


  login = (email, password) ->

    _deferred = $q.defer()

    Restangular.one('login').post().then (response) ->
      console.log email, password

      _deferred.resolve response


    return _deferred.promise



  register = (email, password, repeatPassword, username) ->

    _deferred = $q.defer()

    Restangular.one('register').post().then (response) ->
      console.log email, password, repeatPassword, username

      _deferred.resolve response


    return _deferred.promise



  api =
    login:    login
    register: register



  return api
