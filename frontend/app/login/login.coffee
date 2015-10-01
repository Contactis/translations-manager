angular.module('translation.login', [
  'ui.router'
  'authorizationService'
  'ngCookies'
  'restangular'
  'userPermissionsSettings'
  'userService'
])

.config ($stateProvider, userPermissionsSettingsProvider) ->

  access = userPermissionsSettingsProvider.accessLevels

  $stateProvider.state 'app.login',
    url:            '/login'
    controller:     'LoginController'
    templateUrl:    'login/login.tpl.html'
    data:
      access:       access.anon

.controller 'LoginController', ($scope, $cookies, $state, $http, authorization, Restangular, userService) ->


  $scope.user =
    email: ''
    password: ''
    repeatPassword: ''
    username: ''


  $scope.showRegistration = false

  $scope.toggleRegister = ->
    $scope.showRegistration = !$scope.showRegistration



  $scope.login = ->
    authorization.login $scope.user.email, $scope.user.password
    .then (token) ->

      if angular.isDefined token.token
        $cookies.put 'token', token.token
        $http.defaults.headers.common['authorization'] = token.token

        Restangular.one('profile').get()
        .then (response) ->
          response = response.plain()
          response['loggedIn'] = true
          userService.sync response
          $state.go 'app.dashboard'

    , (error) ->
      console.log 'error occured', error


  $scope.register = ->
    authorization.register $scope.user.email, $scope.user.password, $scope.user.repeatPassword, $scope.user.username

  $scope.sizes = [
    "small (12-inch)"
    "medium (14-inch)"
    "large (16-inch)"
    "insane (42-inch)"
  ]

  return


