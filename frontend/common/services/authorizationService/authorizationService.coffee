angular.module 'authorizationService', [
  'restangular'
  'ui.router'
  'userService'
  'ngMaterial'
]


.service 'authorization', ($q, $state, $mdToast, Restangular, user) ->

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



  _kickUnauthorised = (queue, event) ->
    event.preventDefault()
    if user.getData('loggedIn')
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
    register:     register
    accessCheck:  _pageAccessCheck

    authorizePageAccess: (accessLevel, role) ->
      if typeof role is 'undefined'
        role = user.getData('role')
      result = accessLevel.bitMask & role.bitMask
      return result


  return api
