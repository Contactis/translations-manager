angular.module('translation.pages.admin.project-assignment', [
  'lbServices'
])
.config ($stateProvider, UserPermissionsSettingsProvider) ->

  access = UserPermissionsSettingsProvider.accessLevels

  $stateProvider.state 'app.admin.project-assignment',
    url:            '/project-assignment'
    controller:     'ProjectAssignmentController'
    controllerAs:   'vm'
    templateUrl:    'admin/projectAssignment/projectAssignment.tpl.html'
    data:
      access: access.management

.controller 'ProjectAssignmentController', (Project, Account) ->

  vm = this

  vm.projects = {}
  vm.accounts = {}

  Project.find
    filter:
      include: [
        'accounts'
      ]
  .$promise.then (response) ->
    vm.projects = response

  Account.find().$promise.then (response) ->
    vm.accounts = response








  return vm

