# # Programmer view

# @module       translation.pages.programmer-view
angular.module('translation.pages.programmer-view', [
  'ui.router'
  'ngCookies'
  'data-table'
  'ngMessages'
  'ngAnimate'
  'lbServices'
  'translation.providers.userPermissionsSettings'
  'ui.bootstrap'
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
                "modifiedBy"
              ]
              "project"
              "namespace"
            ]
        .$promise

.controller 'ProgrammerViewController', ($log, $http, $timeout, $cookies, $uibModal,
TranslationKeysResolver, TranslationKey, Namespace) ->
  vm              = this

  vm.query        = ""
  vm.filters      = {}
  vm.contextMenu  = {}
  vm.tableData    = []

  vm.tableData = TranslationKeysResolver

  $timeout () ->
    vm.contextMenu.name   = "Programmer"
    vm.contextMenu.links  = [
      {
        name: "Export selected to..."
        method: "exportSelectedTo()"
      }
    ]
    return

  # .then (success)->
  #   vm.tableData = success
  #   vm.displayedCollection = [].concat(vm.tableData)
  #   $log.info "ZAŁADOWANO", success
  # , (error) ->
  #   $log.error "Problem with loading translation keys", error
  #   msg = $('translate')('APP.FRONTEND_MESSAGES.PROGRAMMER_VIEW.LOADING_TRANSLATION_KEYS_FAILED')
  #   toastr.error msg



  vm.open = ->
    $uibModal.open(
      animation:    true
      templateUrl:  'templates/dialog/addTranslationKey.tpl.html'
      controller:   'AddTranslationKeyController'
      controllerAs: 'vm'
      size:         'lg'
      windowClass:  'center-modal'
    )

  return vm



