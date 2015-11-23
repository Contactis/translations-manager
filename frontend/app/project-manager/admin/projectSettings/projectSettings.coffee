angular.module('translation.pages.admin.project-settings', [
  'lbServices'
])
.config ($stateProvider, UserPermissionsSettingsProvider) ->

  access = UserPermissionsSettingsProvider.accessLevels

  $stateProvider.state 'app.admin.project-settings',
    url:            '/project-settings'
    controller:     'ProjectSettingsController'
    controllerAs:   'vm'
    templateUrl:    'admin/projectSettings/projectSettings.tpl.html'
    data:
      access: access.management

.controller 'ProjectSettingsController', () ->

  vm = this

  return vm
