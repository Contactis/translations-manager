angular.module 'userService', [
  'restangular'
  'ngCookies'
  'ui.router'
  'userPermissionsSettings'
]

.service 'user', ($q, $cookies, $http, $state, Restangular, userPermissionsSettings) ->

  accessLevels  = userPermissionsSettings.accessLevels
  userRoles     = userPermissionsSettings.userRoles


  _deferred = null

  user =
    loggedIn:   false
    username:   'Unknown'
    firstName:  'First name'
    lastName:   'Last name'
    token:      ''
    role:       userRoles.public



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

    getData:  (key) ->
      return user[key]



  return api
