angular.module 'translation.services.authorization', [
  'ui.router'
  'toastr'
  'ngCookies'
  'lbServices'
  'translation.modules.languages'
  'translation.services.account'
  'translation.providers.userPermissionsSettings'
]

.service 'AuthorizationService', ($q, $state, $timeout, $filter, toastr, AccountService, Account,
LanguagesService, UserPermissionsSettings) ->

  userRoles = UserPermissionsSettings.userRoles

  _authorizePageAccess = (accessLevel, role) ->
    if typeof role is 'undefined'
      role = AccountService.getData('role')
    result = accessLevel.bitMask & role.bitMask
    return result

  _login = (rememberMe, email, password) ->
    _deferred = $q.defer()

    _credentials =
      email:      email
      password:   password

    Account.login {rememberMe: rememberMe},  _credentials
      , (response) ->

        response = response.toJSON()
        response.user.role = userRoles[response.user.role]

        AccountService.setAccount response.user
        userLang = LanguagesService.getStartupLanguage(response.user.interfaceLanguage)
        LanguagesService.setLanguage(userLang)
        _deferred.resolve response.user
      , (error) ->
        console.log "error", error
        _deferred.reject error

    return _deferred.promise


  _register = (attributes) ->
    _deferred = $q.defer()

    Account.create(attributes).$promise.then (response) ->
      _deferred.resolve response
    , (err) ->
      _deferred.reject err

    return _deferred.promise



  _kickUnauthorised = (queue, event) ->
    event.preventDefault()
    if Account.isAuthenticated()
      $state.go 'app.manager.dashboard'
    else
      $state.go 'login'
    return queue.resolve()


  api =
    authorizePageAccess:  _authorizePageAccess
    login:        _login
    register:     _register
    logout:       ->
      Account.logout().$promise.then ->
        AccountService.resetAccount()
        $state.go 'login'
        msg = $filter('translate')('APP.FRONTEND_MESSAGES.AUTHORIZATION.YOU_HAD_BEEN_LOGGED_OUT')
        toastr.info msg
        return
      return

    accessCheck:  (event, toState) ->
      _accessDeffered = $q.defer()

      if angular.isUndefined(toState) or !('data' of toState) or !('access' of toState.data)
        if angular.isDefined(event)
          event.preventDefault()
        msg = $filter('translate')('APP.FRONTEND_MESSAGES.AUTHORIZATION.ACCESS_UNDEFINED_FOR_THIS_STATE')
        toastr.warning msg

        _kickUnauthorised _accessDeffered, event
      else
        if _authorizePageAccess(toState.data.access)
          _accessDeffered.resolve()
        else
          msg = $filter('translate')('APP.FRONTEND_MESSAGES.AUTHORIZATION.SEEMS_LIKE_YOU_DONT_HAVE_PERMISSIONS')
          toastr.error msg
          _kickUnauthorised _accessDeffered, event
      return _accessDeffered.promise

  return api
