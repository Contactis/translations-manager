angular.module('translation.home', [
  'ui.router'
])

.config ($stateProvider) ->

  $stateProvider.state 'home',
    url:            '/home'
    controller:     'HomeController'
    templateUrl:    'home/home.tpl.html'

.controller 'HomeController', ($scope) ->

  return


