angular.module('translation.login', [
  'ui.router'
  'authorisationService'
])

.config ($stateProvider) ->

  $stateProvider.state 'app.login',
    url:            '/login'
    controller:     'LoginController'
    templateUrl:    'login/login.tpl.html'

.controller 'LoginController', ($scope, authorisation) ->


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


  $scope.register = ->
    authorisation.register $scope.user.email, $scope.user.password, $scope.user.repeatPassword, $scope.user.username



  return


