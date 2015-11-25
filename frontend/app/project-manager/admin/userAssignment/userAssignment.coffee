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
      ProjectAccountsResolver: (ProjectAccount, CurrentProjectResolver) ->
        result = ProjectAccount.find
          filter:
            where:
              projectId: CurrentProjectResolver.id
        return result.$promise




.controller 'UserAssignmentController', ($log, $filter, $q, toastr, Project, Account, ProjectAccount,
ProjectAccountsResolver, CurrentProjectResolver, CurrentProjectAccountsResolver, AllAccountsResolver, HelperService) ->
  vm = this

  # @variable     vm.selectedUsersList
  # @description  Loopback model of accounts assigned to current selected project
  vm.currentProject         = CurrentProjectResolver
  vm.currentProjectAccounts = CurrentProjectAccountsResolver
  vm.allAccounts            = AllAccountsResolver
  vm.projectAccounts        = ProjectAccountsResolver


  # @private
  # @description  simple assing result to variable to avoid multiple method call
  _partitionArray = () ->
    HelperService.partitionGreaterArrayByParameter(AllAccountsResolver, \
      vm.currentProjectAccounts.accounts, 'id')


  # @public
  # @variable     vm.selectedUsersList
  # @description  accounts bind with reference to `vm.currentProjectAccounts`
  vm.selectedUsersList = _partitionArray()[0]


  # @public
  # @variable     vm.availableAccounts
  # @description  accouts that are still available to select
  vm.availableAccounts = _partitionArray()[1]


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

  _getBuildedProjectAccountModel = () ->
    _tmpArray = []
    if not vm.selectedUsersList.length <= 0
      for x in vm.selectedUsersList
        _tmpObj =
          projectId: vm.currentProject.id
          accountId: x.id
        _tmpArray.push _tmpObj
    return _tmpArray


  # @private
  # @method       _removeAllRelatedEntities
  # @description  removing all related entities from database
  _removeAllRelatedEntities = () ->
    _removingPromises = []
    _deferred = $q.defer()

    # TODO if not vm.selectedUsersList == vm.projectAccounts
    for x in vm.projectAccounts
      $log.info "x", x.id
      _removingPromises.push ProjectAccount.deleteById({id: x.id}).$promise

    $q.all(_removingPromises).then (success) ->
      _deferred.resolve success
    , (e) ->
      _deferred.reject e


  # @private
  # @method       _savingAllNewEntities
  # @description  save all related entities to the database
  _savingAllNewEntities = () ->
    _newPromises = []
    _deferred = $q.defer()

    list = _getBuildedProjectAccountModel() # generate array model for backend
    $log.warn "list", list
    if list.length > 0
      for y in list
        _newPromises.push ProjectAccount.create(y).$promise

    $q.all().then (success) ->
      _deferred.resolve success
    , (error) ->
      _deferred.reject error


  # @public
  # @method       vm.addToSelectedList
  vm.saveSelectedUsers = () ->
    _removeAllRelatedEntities().then (response) ->
      toastr.success "All related entities removed successfully"
      _savingAllNewEntities().then (result) ->
        msg = $filter('translate')('APP.FRONTEND_MESSAGES.SUCCESSFULLY_SAVED_THE_DATA')
        toastr.success msg
      , (resultError) ->
        msg = $filter('translate')('APP.FRONTEND_MESSAGES.ERROR_OCCURED_WHILE_SAVING_THE_DATA') +
          ' ' + $filter('translate')('APP.FRONTEND_MESSAGES.TRY_AGAIN_LATER') +
          ' Error detail:' + resultError
        toastr.success msg
    , (responseError) ->
      toastr.success "All related entities removed successfully"


  return vm
