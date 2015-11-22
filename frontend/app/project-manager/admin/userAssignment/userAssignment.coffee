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
      CurrentProjectResolver: (CurrentProjectService) ->
        return CurrentProjectService.getCurrentProject()
      AllAccountsResolver: (Account) ->
        return Account.find().$promise
      CurrentProjectAccountsResolver: (Project, CurrentProjectResolver) ->
        response = Project.findOne
          filter:
            where:
              id: CurrentProjectResolver.id
            include: [
              "accounts"
            ]
        return response.$promise


.controller 'UserAssignmentController', ($log, Project, Account, CurrentProjectAccountsResolver, AllAccountsResolver,
HelperService) ->
  vm = this

  # @public
  # @variable     vm.currentProjectAccounts
  # @description  TODO
  vm.currentProjectAccounts = CurrentProjectAccountsResolver




  # @public
  # @variable     vm.availableAccounts
  # @description  TODO
  vm.availableAccounts = HelperService.diffArrayObjects(vm.currentProjectAccounts.accounts, AllAccountsResolver, 'id')


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
