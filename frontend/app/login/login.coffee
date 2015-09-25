angular.module('translation.login', [
  'ui.router'
  'authorisationService'
  'ngCookies'
])

.config ($stateProvider) ->

  $stateProvider.state 'app.login',
    url:            '/login'
    controller:     'LoginController'
    templateUrl:    'login/login.tpl.html'

.controller 'LoginController', ($scope, $cookies, authorisation) ->


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

        Restangular.all('profile').get()
        .then (response) ->
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


