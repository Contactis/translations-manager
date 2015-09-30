angular.module 'authorisationService', [
  'restangular'
  'ui.router'
  'userService'
  'userPermissionsSettings'
]

.service 'authorisation', ($q, $state, Restangular, user, userPermissionsSettings) ->


  accessLevels  = userPermissionsSettings.accessLevels
  userRoles     = userPermissionsSettings.userRoles

  login = (email, password) ->

    _deferred = $q.defer()

    Restangular.all('login').post
      email:          email
      password:       password
    .then (response) ->

      _deferred.resolve response

    , (err) ->
      _deferred.reject err


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





  _pageAccessCheck = (event, toState) ->


    _queue = $q.defer()

    if angular.isUndefined(toState) or !('data' of toState) or !('access' of toState.data)
# Missing state
      if angular.isDefined(event)
        event.preventDefault()

#      GlobalNotificationsService.add
#        msg:"ACCESS_UNDEFINED_FOR_THIS_STATE"
#        type:"warning"

      $state.go 'home'
      _queue.resolve()
    else
      if api.authorizePageAccess(toState.data.access)
        _queue.resolve()
      else
        event.preventDefault()
#        GlobalNotificationsService.add
#          msg:    "SEEMS_LIKE_YOU_TRIED_ACCESSING_A_ROUTE_YOU_DONT_HAVE_ACCESS_TO"
#          type:   "error"

        $state.go 'app.login'
        _queue.resolve()


    return _queue.promise

  api =
    login:        login
    register:     register
    accessCheck:  _pageAccessCheck

    authorizePageAccess: (accessLevel, role) ->
      if typeof role is 'undefined'
        role = user.getData('role')
      result = accessLevel.bitMask & role.bitMask
      return result


  return api
