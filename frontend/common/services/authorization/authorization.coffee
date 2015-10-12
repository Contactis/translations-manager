angular.module 'translation.services.authorization', [
  'ui.router'
  'ngMaterial'
  'ngCookies'
  'translation.services.user'
  'lbServices'
]

.service 'AuthorizationService', ($q, $state, $mdToast, $cookies, $http, UserService, Account) ->


  login = (email, password) ->

    _deferred = $q.defer()
    Account.login
      email:          email
      password:       password
    .then (response) ->

      _deferred.resolve response
      UserService.loadDashboard response

    , (error) ->

      _deferred.reject error

      $mdToast.show(
        $mdToast.simple()
        .content('Login unsuccessful. Try again.')
        .position('bottom right')
        .hideDelay(3000)
      )

    return _deferred.promise


  register = (attributes) ->

    return Restangular.all('register').post(
      email:      attributes.email
      password:   attributes.password
      firstName:  attributes.firstName
      lastName:   attributes.lastName
    )

  logout = ->

    $cookies.remove 'token'
    UserService.resetUser()
    delete $http.defaults.headers.common['authorization']
    $state.go 'app.login'

    $mdToast.show(
      $mdToast.simple()
      .content('You had been logged out.')
      .position('bottom right')
      .hideDelay(3000)
    )



  _kickUnauthorised = (queue, event) ->
    event.preventDefault()
    if UserService.getData('loggedIn')
      $state.go 'app.dashboard'
    else
      $state.go 'app.login'

    queue.resolve()


  _pageAccessCheck = (event, toState) ->
    _queue = $q.defer()

    if angular.isUndefined(toState) or !('data' of toState) or !('access' of toState.data)
# Missing state
      if angular.isDefined(event)

        $mdToast.show(
          $mdToast.simple()
          .content('Access undefined for this state')
          .position('bottom right')
          .hideDelay(3000)
        )
        _kickUnauthorised _queue, event
    else
      if api.authorizePageAccess(toState.data.access)
        _queue.resolve()
      else

        $mdToast.show(
          $mdToast.simple()
          .content('Seems like you don\'t have permissions to access that page.')
          .position('bottom right')
          .hideDelay(3000)
        )

        _kickUnauthorised _queue, event

    return _queue.promise


  api =
    login:        login
    logout:       logout
    register:     register
    accessCheck:  _pageAccessCheck

    authorizePageAccess: (accessLevel, role) ->
      if typeof role is 'undefined'
        role = UserService.getData('role')
      result = accessLevel.bitMask & role.bitMask
      return result

  return api
