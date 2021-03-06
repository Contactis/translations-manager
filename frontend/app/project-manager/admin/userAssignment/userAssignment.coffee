angular.module('translation.pages.admin.user-assignment', [
  'lbServices'
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
      access:       access.admin
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
  # @description  simple assinginig result to variable to avoid multiple method call
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


  # @private
  # @method       _getBuildedProjectAccountModel
  # @description  Build Array of objects which can be used to save data to the
  #               backend
  # @returns      {Array}
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
  # @returns      {Promise}
  _removeAllRelatedEntities = () ->
    _removingPromises = []
    _deferred = $q.defer()

    # TODO if not vm.selectedUsersList == vm.projectAccounts
    for x in vm.projectAccounts
      _removingPromises.push ProjectAccount.deleteById({id: x.id}).$promise

    $q.all(_removingPromises).then (success) ->
      msg = $filter('translate')('APP.FRONTEND_MESSAGES.USER_ASSIGNMENT.REMOVED_ENTITIES_SUCCESSFULLY')
      _deferred.resolve msg
    , (e) ->
      msg = $filter('translate')('APP.FRONTEND_MESSAGES.USER_ASSIGNMENT.REMOVED_ENTITIES_FAILED')
      _deferred.reject msg
    return _deferred.promise


  # @private
  # @method       _savingAllNewEntities
  # @description  save all related entities to the database
  # @returns      {Promise}
  _savingAllNewEntities = () ->
    _newPromises = []
    _deferred = $q.defer()

    list = _getBuildedProjectAccountModel() # generate array model for backend
    if list.length > 0
      for y in list
        _newPromises.push ProjectAccount.create(y).$promise

    $q.all().then (success) ->
      msg = $filter('translate')('APP.FRONTEND_MESSAGES.SUCCESSFULLY_SAVED_THE_DATA')
      _deferred.resolve msg
    , (error) ->
      msg = $filter('translate')('APP.FRONTEND_MESSAGES.ERROR_OCCURED_WHILE_SAVING_THE_DATA') +
          ' ' + $filter('translate')('APP.FRONTEND_MESSAGES.TRY_AGAIN_LATER') +
          ' Error detail:' + error
      _deferred.reject msg
    return _deferred.promise


  # @public
  # @method       vm.addToSelectedList
  # @description  Removing and saving all related entities
  vm.saveSelectedUsers = () ->
    _removeAllRelatedEntities().then (response) ->
      toastr.success response
      _savingAllNewEntities().then (result) ->
        toastr.success result
      , (resultError) ->
        toastr.error resultError
    , (responseError) ->
      toastr.error responseError


  return vm
