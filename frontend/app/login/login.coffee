angular.module('translation.pages.login', [
  'ui.router'
  'pascalprecht.translate'
  'ngCookies'
  'restangular'
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


.controller 'LoginController', ($scope, $state, $http, Restangular, AuthorizationService, toastr) ->

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


      toastr.success('Welcome!')
    , (error) ->
      toastr.error error


  $scope.register = ->
    if $scope.user.password != $scope.user.repeatPassword
      toastr.warning 'Passwords don\'t match. Try again'
    else
      AuthorizationService.register
        email:      $scope.user.email
        password:   $scope.user.password
        firstName:  $scope.user.firstName
        lastName:   $scope.user.lastName
        username:   $scope.user.username
      .then $scope.login
      , (error) ->
        toastr.error error.data.error.message
        return

  $scope.sizes = [
    "small (12-inch)"
    "medium (14-inch)"
    "large (16-inch)"
    "insane (42-inch)"
  ]

  return


