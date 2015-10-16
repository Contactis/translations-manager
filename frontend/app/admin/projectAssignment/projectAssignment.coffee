angular.module('translation.pages.admin.project-assignment', [

])
.config ($stateProvider, UserPermissionsSettingsProvider) ->

  access = UserPermissionsSettingsProvider.accessLevels

  $stateProvider.state 'app.admin.project-assignment',
    url:            '/project-assignment'
    controller:     'ProjectAssignmentController'
    templateUrl:    'admin/projectAssignment/projectAssignment.tpl.html'
    data:
      access: access.management

.controller 'ProjectAssignmentController', () ->
  console.log 'jestem'
