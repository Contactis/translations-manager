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
    data:
      access:       access.management
    resolve:
      currentProject: (CurrentProjectService) ->
        return CurrentProjectService.getCurrentProject()
      allAccounts: (Account) ->
        return Account.find().$promise
      currentProjectAccountsResolver: (Project, currentProject) ->
        response = Project.findOne
          filter:
            where:
              id: currentProject.id
            include: [
              "accounts"
            ]
        return response.$promise

.controller 'UserAssignmentController', ($log, Project, Account, currentProjectAccountsResolver, allAccounts,
HelperService) ->
  vm = this

  # @public
  # @variable     vm.currentProjectAccounts
  # @description  TODO
  vm.currentProjectAccounts = currentProjectAccountsResolver


  # @public
  # @variable     vm.availableAccounts
  # @description  TODO
  vm.availableAccounts = HelperService.diffArrayObjects(vm.currentProjectAccounts.accounts, allAccounts, 'id')


  # @variable     vm.selectedUsersList
  vm.selectedUsersList = []


  # @private
  # @method       _moveObject
  _moveObject = (fromArray, toArray, index) ->
    obj = fromArray.splice(index, 1)
    toArray.push obj[0]


  # @public
  # @method       vm.addToSelectedList
  vm.addToSelectedList = (index) ->
    _moveObject(vm.availableAccounts, vm.selectedUsersList, index)
    return true


  # @public
  # @method       vm.addToUnselectedList
  vm.addToUnselectedList = (index) ->
    _moveObject(vm.selectedUsersList, vm.availableAccounts, index)
    return


  # @public
  # @method       vm.addToSelectedList
  vm.saveSelectedUsers = () ->
    $log.info "vm.saveSelectedUsers() called"


  return vm
