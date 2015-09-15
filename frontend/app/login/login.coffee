angular.module('translation.login', [
  'ui.router'
])

.config ($stateProvider) ->

  $stateProvider.state 'login',
    url:            '/login'
    controller:     'loginController'
    templateUrl:    'login/login.tpl.html'
    parent:         'app'

.controller 'loginController', ($scope) ->
