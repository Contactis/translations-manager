# # Programmer view

# @module       translation.pages.programmer-view
angular.module('translation.pages.programmer-view', [
  'ui.router'
  'ngCookies'
  'data-table'
  'toastr'
  'ngMessages'
  'ngAnimate'
  'ui.bootstrap'
  'lbServices'
  'translation.providers.userPermissionsSettings'
  'translation.services.plural'
  'translation.directives.trWaitingSpinnerSpan'
])

.config ($stateProvider, UserPermissionsSettingsProvider) ->

  access = UserPermissionsSettingsProvider.accessLevels

  $stateProvider.state 'app.manager.programmer-view',
    url:            '/programmer-view'
    controller:     'ProgrammerViewController'
    controllerAs:   'vm'
    templateUrl:    'project-manager/programmer-view/programmer-view.tpl.html'
    data:
      access:       access.user
    resolve:
      TranslationKeysResolver: (TranslationKey) ->
        TranslationKey.find
          filter:
            include: [
              "translations": [
                "language"
                "lastModifiedBy"
                "statusId"
              ],
              "project"
              "namespace"
            ]
        .$promise
      CurrentProjectResolver:  (CurrentProjectService) ->
        return CurrentProjectService.getCurrentProject()

.controller 'ProgrammerViewController', ($rootScope, $scope, $log, $http, $filter, $timeout, toastr,
$cookies, $uibModal, TranslationKeysResolver, CurrentProjectResolver, TranslationKey, Namespace,
PluralService) ->
# $rootScope is used for $on object which listen to $emit/$broadcast
# $scope is used for $watch
  vm = this

  vm.pending                    = true
  vm.query                      = ""
  vm.filters                    = {}
  vm.contextMenu                = {}
  vm.tableData                  = TranslationKeysResolver
  vm.currentProject             = CurrentProjectResolver


  # @private
  # @method       _reloadList
  # @description  Reloading programmer list of translations keys
  _reloadList = ->
    TranslationKey.find
      filter:
        include: [
          "translations": [
            "language"
            "lastModifiedBy"
            "statusId"
          ],
          "project"
          "namespace"
        ]
    .$promise.then (success) ->
      $log.info "programmer list reload successfully"
      vm.tableData = success
      return
    , (error) ->
      toastr.warning "List could not be updated. Please realod page again."
      return


  # @method       vm.addNewKey
  # @description  Open modal with adding new index key form
  vm.addNewKey = ->
    $uibModal.open
      animation:    true
      templateUrl:  'templates/dialog/addTranslationKey.tpl.html'
      controller:   'AddTranslationKeyController'
      controllerAs: 'vm'
      size:         'lg'
      windowClass:  'center-modal'


  # @public
  # @method       vm.getNameOfPlural
  # @description  Get name of plural with given id
  vm.getNameOfPlural = (id) ->
    return PluralService.getPlural(id).name


  vm.whatClass = (isPlural) ->
    return if isPlural then 'text-success' else 'text-danger'


  vm.editRow = (translationId) ->
    toastr.info $filter('translate')('APP.FRONTEND_MESSAGES.THIS_FEATURE_IS_NOT_YET_READY')
    $log.info "opened", translationId


  $rootScope.$on 'reloadProgrammerTranslationList', (event, data) ->
    $log.info "reloadProgrammerTranslationList"
    _reloadList()


  return vm



