angular.module('userService', [
  'restangular'
  'ngCookies'
  'ui.router'
  'userPermissionsSettings'
])
.service 'userService', ($q, $cookies, $http, $timeout, $state, Restangular, userPermissionsSettings) ->

  accessLevels  = userPermissionsSettings.accessLevels
  userRoles     = userPermissionsSettings.userRoles

  _notify = $q.defer()

  _deferred = null

  defaultUserObject =
    id:         ''
    createdAt:  ''
    updatedAt:  ''
    email:      ''
    loggedIn:   false
    username:   ''
    firstName:  ''
    lastName:   ''
    fullName:   ''
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

      $timeout ->
        _notify.notify user

    , (error) ->
      _deferred.resolve error

    return _deferred.promise



  api =
    getSession: getSession
    user: ->
      return angular.copy user
    updated:  _notify.promise

    getData: (key) ->
      return user[key]

    logout: () ->
      console.log 'logout'
      $cookies.remove 'token'
      user = angular.copy defaultUserObject

      $timeout ->
        _notify.notify user

      delete $http.defaults.headers.common['authorization']

      $state.go 'app.login'

    sync: (newUserObject) ->
      angular.forEach defaultUserObject, (val, key) ->
        user[key] = newUserObject[key]

      $timeout ->
        _notify.notify user

      return user



  return api
