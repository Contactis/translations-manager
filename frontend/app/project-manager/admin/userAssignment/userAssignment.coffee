angular.module('translation.pages.admin.user-assignment', [
  'lbServices'
  'restangular'
  'translation.services.current-project'
  'translation.services.helper'
  'toastr'
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
      AllAccountsResolver: (Account) ->
        return Account.find().$promise
      CurrentProjectResolver: (CurrentProjectService) ->
        return CurrentProjectService.getCurrentProject()
      CurrentProjectAccountsResolver: (Project, CurrentProjectResolver) ->
        response = Project.findOne
          filter:
            where:
              id: CurrentProjectResolver.id
            include: [
              "accounts"
            ]
        return response.$promise


.controller 'UserAssignmentController', ($log, $filter, Project, Account,
CurrentProjectAccountsResolver, AllAccountsResolver, toastr, HelperService) ->
  vm = this

  # @variable     vm.selectedUsersList
  # @description  Loopback model of accounts assigned to current selected project
  vm.currentProjectAccounts = CurrentProjectAccountsResolver
  vm.allAccounts = AllAccountsResolver


  _partitionArray = HelperService.partitionGreaterArrayByParameter(AllAccountsResolver, \
    vm.currentProjectAccounts.accounts, 'id')

  console.log _partitionArray

  # @public
  # @variable     vm.selectedUsersList
  # @description  accounts bind with reference to `vm.currentProjectAccounts`
  vm.selectedUsersList = _partitionArray[0]


  # @public
  # @variable     vm.availableAccounts
  # @description  accouts that are still available to select
  vm.availableAccounts = _partitionArray[1]


  # @private
  # @method       _moveObject
  # @description  Splice object of given index from `fromArray` to `toArray`.
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
    Project.create vm.selectedUsersList
    vm.currentProjectAccounts.$save().then (success) ->
      $log.info "success", success
      msg = $filter('translate')('APP.FRONTEND_MESSAGES.SUCCESSFULLY_SAVED_THE_DATA')
      toastr.success msg
      return true
    , (e) ->
      $log.info "e", e
      msg = $filter('translate')('APP.FRONTEND_MESSAGES.ERROR_OCCURED_WHILE_SAVING_THE_DATA') +
        ' ' + $filter('translate')('APP.FRONTEND_MESSAGES.TRY_AGAIN_LATER') +
        ' Error detail:' + e
      toastr.error msg
      return false





  return vm
