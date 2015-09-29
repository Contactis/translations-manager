angular.module 'userService', [
  'restangular'
  'ngCookies'
  'ui.router'
]

.service 'user', ($q, $cookies, $http, $state, Restangular) ->

  _deferred = null

  user =
    loggedIn:   false
    username:   'Unknown'
    firstName:  'First name'
    lastName:   'Last name'
    token:      ''



  getSession = ->

    if _deferred
      return _deferred.promise

    _deferred = $q.defer()

    token = $cookies.get 'token'


    if token
      $http.defaults.headers.common['authorization'] = token

      Restangular.one('profile').get().then (response) ->
        console.log response
        user.loggedIn = true
        $state.go 'app.dashboard'
      , (error) ->
        console.log error





    _deferred.resolve user


    return _deferred.promise


  api =
    getSession: getSession
    user: user



  return api
