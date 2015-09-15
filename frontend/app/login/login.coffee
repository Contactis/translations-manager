angular.module('translation.login', [
  'ui.router'
])

.config ($stateProvider) ->

  $stateProvider.state 'app.login',
    url:            '/login'
    controller:     'LoginController'
    templateUrl:    'login/login.tpl.html'

.controller 'LoginController', ($scope) ->
  console.log 'LoginController'
  return


