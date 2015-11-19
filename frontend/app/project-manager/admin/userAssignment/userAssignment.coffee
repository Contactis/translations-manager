angular.module('translation.pages.admin.user-assignment', [
  'lbServices'
])
.config ($stateProvider, UserPermissionsSettingsProvider) ->

  access = UserPermissionsSettingsProvider.accessLevels

  $stateProvider.state 'app.admin.user-assignment',
    url:            '/user-assignment'
    controller:     'UserAssignmentController'
    controllerAs:   'vm'
    templateUrl:    'project-manager/admin/userAssignment/userAssignment.tpl.html'
    data:
      access: access.management

.controller 'UserAssignmentController', (Project, Account) ->

  vm = this


  return vm
