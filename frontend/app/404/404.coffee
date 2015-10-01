angular.module('translation.404', [
  'ui.router'
  'userPermissionsSettings'
])

.config ($stateProvider, userPermissionsSettingsProvider) ->

  access = userPermissionsSettingsProvider.accessLevels

  $stateProvider.state '404',
    url:            '/404'
    controller:     'Page404Controller'
    templateUrl:    '404/404.tpl.html'
    data:
      access: access.public

.controller 'Page404Controller', ($scope) ->

  return


