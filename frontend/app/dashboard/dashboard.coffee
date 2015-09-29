angular.module('translation.dashboard', [
  'ui.router'
  'userPermissionsSettings'
  'data-table'
])

.config ($stateProvider, userPermissionsSettingsProvider) ->

  access = userPermissionsSettingsProvider.accessLevels

  $stateProvider.state 'app.dashboard',
    url:            '/dashboard'
    controller:     'DashboardController'
    templateUrl:    'dashboard/dashboard.tpl.html'
    data:
      access: access.user

.controller 'DashboardController', ($scope) ->
  return
