angular.module 'translation.services.authorization', [
  'ui.router'
  'ngMaterial'
  'ngCookies'
  'translation.services.account'
  'lbServices'
]

.service 'AuthorizationService', ($q, $state, $mdToast, $timeout, AccountService, Account) ->

  login = (rememberMe, email, password) ->

    _deferred = $q.defer()

    _credentials =
        email:          email
        password:       password

    Account.login {rememberMe: rememberMe},  _credentials,
    (response) ->

      response = response.toJSON()
      AccountService.setAccount(response.user)
      _deferred.resolve response.user

    , (error) ->

      _deferred.reject error


    return _deferred.promise


  register = (attributes) ->

    return Restangular.all('register').post(
      email:      attributes.email
      password:   attributes.password
      firstName:  attributes.firstName
      lastName:   attributes.lastName
    )

  _kickUnauthorised = (queue, event) ->

    event.preventDefault()

    if Account.isAuthenticated()
      $state.go 'app.dashboard'
    else
      $state.go 'app.login'

    queue.resolve()

  api =
    login:        login

    register:     register

    logout:       ->

      Account.logout().$promise.then ->
        AccountService.resetAccount()

        $state.go 'app.login'

      $mdToast.show(
        $mdToast.simple()
        .content('You had been logged out.')
        .position('bottom right')
        .hideDelay(3000)
      )

    accessCheck:  (event, toState) ->

      _accessDeffered = $q.defer()

      if angular.isUndefined(toState) or !('data' of toState) or !('access' of toState.data)

        $mdToast.show(
          $mdToast.simple()
          .content('Access undefined for this state')
          .position('bottom right')
          .hideDelay(3000)
        )
        _kickUnauthorised _accessDeffered, event
      else
        if api.authorizePageAccess(toState.data.access)
          _accessDeffered.resolve()
        else

          $mdToast.show(
            $mdToast.simple()
            .content('Seems like you don\'t have permissions to access that page.')
            .position('bottom right')
            .hideDelay(3000)
          )

          _kickUnauthorised _accessDeffered, event

      return _accessDeffered.promise

    authorizePageAccess: (accessLevel, role) ->
      if typeof role is 'undefined'
        role = AccountService.getData('role')
      result = accessLevel.bitMask & role.bitMask
      return result

  return api
