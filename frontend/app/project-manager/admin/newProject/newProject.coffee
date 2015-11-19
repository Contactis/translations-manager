angular.module('translation.pages.admin.new-project', [

])
.config ($stateProvider, UserPermissionsSettingsProvider) ->

  access = UserPermissionsSettingsProvider.accessLevels

  $stateProvider.state 'app.admin.new-project',
    url:            '/new-project'
    controller:     'NewProjectController'
    templateUrl:    'admin/newProject/newProject.tpl.html'
    data:
      access: access.admin

.controller 'NewProjectController', () ->
  console.log 'NewProjectController'
