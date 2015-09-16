angular.module('translation.register', [
  'ui.router'
])

.config ($stateProvider) ->

  $stateProvider.state 'app.register',
    url:            '/register'
    controller:     'RegisterController'
    templateUrl:    'register/register.tpl.html'

.controller 'RegisterController', ($scope) ->

  return