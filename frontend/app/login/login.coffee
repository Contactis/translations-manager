angular.module('translation.login', [
  'ui.router'
  'authorisationService'
  'ngCookies'
  'restangular'
  'userPermissionsSettings'
])

.config ($stateProvider, userPermissionsSettingsProvider) ->

  access = userPermissionsSettingsProvider.accessLevels

  $stateProvider.state 'app.login',
    url:            '/login'
    controller:     'LoginController'
    templateUrl:    'login/login.tpl.html'
    data:
      access:       access.anon

.controller 'LoginController', ($scope, $cookies, $state, $http, authorisation, Restangular) ->


  $scope.user =
    email: ''
    password: ''
    repeatPassword: ''
    username: ''


  $scope.showRegistration = false

  $scope.toggleRegister = ->
    $scope.showRegistration = !$scope.showRegistration



  $scope.login = ->
    authorisation.login $scope.user.email, $scope.user.password
    .then (response) ->
      token = response.plain()



      if angular.isDefined token.token
        $cookies.put 'token', token.token
        $http.defaults.headers.common['authorization'] = token.token

        Restangular.one('profile').get()
        .then (response) ->
          $state.go 'app.dashboard'
          console.log response

    , (error) ->
      console.log 'error occured', error


  $scope.register = ->
    authorisation.register $scope.user.email, $scope.user.password, $scope.user.repeatPassword, $scope.user.username

  $scope.sizes = [
    "small (12-inch)"
    "medium (14-inch)"
    "large (16-inch)"
    "insane (42-inch)"
  ]

  return


