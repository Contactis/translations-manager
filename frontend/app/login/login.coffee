angular.module('translation.pages.login', [
  'ui.router'
  'pascalprecht.translate'
  'ngCookies'
  'restangular'
  'ngMaterial'
  'translation.services.account'
  'translation.services.authorization'
  'translation.providers.userPermissionsSettings'
])

.config ($stateProvider, UserPermissionsSettingsProvider) ->

  access = UserPermissionsSettingsProvider.accessLevels

  $stateProvider.state 'app.login',
    url:            '/login'
    controller:     'LoginController'
    templateUrl:    'login/login.tpl.html'
    data:
      access:       access.anon


.controller 'LoginController', ($scope, $state, $http, $mdToast, Restangular, AuthorizationService, AccountService) ->

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


      $state.go 'app.dashboard'


      $mdToast.show(
        $mdToast.simple()
        .content('Welcome!')
        .position('bottom right')
        .hideDelay(3000)
      )
    , (error) ->
      $mdToast.show(
        $mdToast.simple()
        .content('Login unsuccessful. Try again.')
        .position('bottom right')
        .hideDelay(3000)
      )


  $scope.register = ->
    if $scope.user.password != $scope.user.repeatPassword
      $mdToast.show(
        $mdToast.simple()
        .content('Passwords don\'t match. Try again')
        .position('bottom right')
        .hideDelay(3000)
      )
    else
      AuthorizationService.register
        email:      $scope.user.email
        password:   $scope.user.password
        firstName:  $scope.user.firstName
        lastName:   $scope.user.lastName
        username:   $scope.user.username
      .then $scope.login
      , (err) ->
        $mdToast.show(
          $mdToast.simple()
          .content(err.data.error.message)
          .position('bottom right')
          .hideDelay(3000)
        )
        return

  $scope.sizes = [
    "small (12-inch)"
    "medium (14-inch)"
    "large (16-inch)"
    "insane (42-inch)"
  ]

  return


