angular.module('translation.dashboard', [
  'ui.router'
])

.config ($stateProvider) ->

  $stateProvider.state 'app.dashboard',
    url:            '/dashboard'
    controller:     'DashboardController'
    templateUrl:    'dashboard/dashboard.tpl.html'

.controller 'DashboardController', ($scope) ->

  return


