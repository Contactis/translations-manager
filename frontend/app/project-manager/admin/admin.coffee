angular.module('translation.pages.admin', [])

.config ($stateProvider, UserPermissionsSettingsProvider) ->
  access = UserPermissionsSettingsProvider.accessLevels

  $stateProvider.state 'app.admin',
    abstract:       true
    parent:         'app.manager'
    url:            '/admin'
    controller:     'AdminController'
    templateUrl:    'project-manager/admin/admin.tpl.html'
    data:
      access:       access.user

.controller 'AdminController', ->
  return
