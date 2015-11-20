angular.module('translation.pages.admin.user-assignment', [
  'lbServices'
  'translation.services.current-project'
  'translation.services.helper'
])
.config ($stateProvider, UserPermissionsSettingsProvider) ->

  access = UserPermissionsSettingsProvider.accessLevels

  $stateProvider.state 'app.admin.user-assignment',
    url:            '/user-assignment'
    controller:     'UserAssignmentController'
    controllerAs:   'vm'
    templateUrl:    'project-manager/admin/userAssignment/userAssignment.tpl.html'
    resolve:
      currentProject: (CurrentProjectService) ->
        return CurrentProjectService.getCurrentProject()
      allAccounts: (Account) ->
        return Account.find().$promise
      currentProjectAccounts: (Project, currentProject) ->

        response = Project.findOne
          filter:
            where:
              id: currentProject.id
            include: [
              "accounts"
            ]


        return response.$promise

    data:
      access: access.management

.controller 'UserAssignmentController', (Project, Account, currentProjectAccounts, allAccounts, HelperService) ->

  vm = this

  vm.currentProjectAccounts = currentProjectAccounts

  vm.availableAccounts = HelperService.diffArrayObjects(vm.currentProjectAccounts.accounts, allAccounts, 'id')




  return vm
