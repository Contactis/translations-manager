angular.module('translation.services.user', [
  'restangular'
  'ngCookies'
  'ngMaterial'
  'ui.router'
  'translation.providers.userPermissionsSettings'
])


.service 'UserService', ($q, $cookies, $http, $timeout, $state, $mdToast, Restangular, UserPermissionsSettings) ->

  accessLevels  = UserPermissionsSettings.accessLevels
  userRoles     = UserPermissionsSettings.userRoles

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

  setCredentialsCookie = (credentials) ->
    $cookies.put 'account', JSON.stringify credentials

  getCredentialsCookie = ->
    _credentials = $cookies.get 'account'
    if _credentials
      return JSON.parse _credentials
    else
      return false

  getSession = ->

    if _deferred
      return _deferred.promise

    _deferred = $q.defer()

    credentials = getCredentialsCookie()

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

  syncUserObject = (newUserObject) ->
    angular.forEach defaultUserObject, (val, key) ->
      user[key] = newUserObject[key]

    $timeout ->
      _notify.notify user

    return user


  loadDashboard = (account) ->
    console.log account
    setCredentialsCookie account
#    $http.defaults.headers.common['authorization'] = token
#
#    Restangular.one('profile').get()
#    .then (response) ->
#      response = response.plain()
#      response['loggedIn'] = true
#      syncUserObject response
#
#      $mdToast.show(
#        $mdToast.simple()
#        .content("Welcome #{response.fullName}!")
#        .position('bottom right')
#        .hideDelay(3000)
#      )
#
#      $state.go 'app.dashboard'


  api =
    getSession:           getSession
    sync:                 syncUserObject
    loadDashboard:        loadDashboard
    updated:              _notify.promise
    setCredentialsCookie: setCredentialsCookie
    getCredentialsCookie: getCredentialsCookie

    resetUser: ->
      user = angular.copy defaultUserObject

      $timeout ->
        _notify.notify user

      return

    user: ->
      return angular.copy user

    defaultUserObject: ->
      return angular.copy defaultUserObject

    getData: (key) ->
      return user[key]




  return api
