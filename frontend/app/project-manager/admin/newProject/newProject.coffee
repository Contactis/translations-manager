angular.module('translation.pages.admin.new-project', [
  'pascalprecht.translate'
])
.config ($stateProvider, UserPermissionsSettingsProvider) ->

  access = UserPermissionsSettingsProvider.accessLevels

  $stateProvider.state 'app.admin.new-project',
    url:            '/new-project'
    controller:     'NewProjectController'
    templateUrl:    'project-manager/admin/newProject/newProject.tpl.html'
    data:
      access:       access.admin

.controller 'NewProjectController', () ->
  console.log 'NewProjectController'
  return
