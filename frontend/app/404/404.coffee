angular.module('translation.pages.404', [
  'ui.router'
  'translation.providers.userPermissionsSettings'
])

.config ($stateProvider, UserPermissionsSettingsProvider) ->

  access = UserPermissionsSettingsProvider.accessLevels

  $stateProvider.state '404',
    url:            '/404'
    controller:     'Page404Controller'
    templateUrl:    '404/404.tpl.html'
    data:
      access: access.public

.controller 'Page404Controller', ($scope) ->

  return


