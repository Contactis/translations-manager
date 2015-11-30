angular.module('translation.pages.login', [
  'ui.router'
  'pascalprecht.translate'
  'ngCookies'
  'toastr'
  'translation.services.account'
  'translation.services.authorization'
  'translation.providers.userPermissionsSettings'
])

.config ($stateProvider, UserPermissionsSettingsProvider) ->

  access = UserPermissionsSettingsProvider.accessLevels

  $stateProvider.state 'login',
    url:            '/login'
    controller:     'LoginController'
    templateUrl:    'login/login.tpl.html'
    data:
      access:       access.anon


.controller 'LoginController', ($scope, $state, $http, $filter, $log,
AuthorizationService, toastr) ->

  $scope.rememberMe = true

  $scope.user =
    email:          ''
    password:       ''
    repeatPassword: ''
    firstName:      ''
    lastName:       ''
    username:       ''


  $scope.showRegistration = false

  $scope.toggleRegister = ->
    $scope.showRegistration = !$scope.showRegistration


  $scope.login = ->
    AuthorizationService.login($scope.rememberMe, $scope.user.email, $scope.user.password).then (account) ->
      $state.go 'app.manager.dashboard'
      msg = $filter('translate')('APP.FRONTEND_MESSAGES.LOGIN.WELCOME')
      toastr.success msg
    , (error) ->
      title = $filter('translate')('APP.FRONTEND_MESSAGES.LOGIN.LOGGING_ERROR')
      msg = error.data.error.message
      toastr.error msg, title


  $scope.register = ->
    if $scope.user.password != $scope.user.repeatPassword
      title = $filter('translate')('APP.FRONTEND_MESSAGES.LOGIN.REGISTRATION_ERROR')
      msg = $filter('translate')('APP.FRONTEND_MESSAGES.LOGIN.PASSWORDS_DONT_MATCH')
      toastr.warning msg, title
    else
      AuthorizationService.register
        email:      $scope.user.email
        password:   $scope.user.password
        firstName:  $scope.user.firstName
        lastName:   $scope.user.lastName
        username:   $scope.user.username
      .then $scope.login
      , (error) ->
        title = $filter('translate')('APP.FRONTEND_MESSAGES.LOGIN.REGISTRATION_ERROR')
        msg = error.data.error.message
        toastr.error msg, title
        return

  $scope.sizes = [
    "small (12-inch)"
    "medium (14-inch)"
    "large (16-inch)"
    "insane (42-inch)"
  ]

  return


