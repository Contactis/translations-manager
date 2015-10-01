angular.module('userService', [
  'restangular'
  'ngCookies'
  'ui.router'
  'userPermissionsSettings'
])
.service 'user', ($q, $cookies, $http, $state, Restangular, userPermissionsSettings) ->

  accessLevels  = userPermissionsSettings.accessLevels
  userRoles     = userPermissionsSettings.userRoles


  _deferred = null

  defaultUserObject =
    loggedIn:   false
    username:   'Unknown'
    firstName:  'First name'
    lastName:   'Last name'
    token:      ''
    role:       userRoles.public


  user = angular.copy defaultUserObject



  getSession = ->

    if _deferred
      return _deferred.promise

    _deferred = $q.defer()

    token = $cookies.get 'token'


    if token
      $http.defaults.headers.common['authorization'] = token

    Restangular.one('profile').get().then (response) ->
      user = response.plain()
      user.loggedIn = true
      _deferred.resolve user
    , (error) ->
      _deferred.resolve error

    return _deferred.promise



  api =
    getSession: getSession
    user: user

    getData: (key) ->
      return user[key]

    logout: () ->
      console.log 'logout'
      $cookies.remove 'token'
      user = angular.copy defaultUserObject
      delete $http.defaults.headers.common['authorization']

      $state.go 'app.login'



  return api
