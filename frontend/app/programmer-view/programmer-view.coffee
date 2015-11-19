angular.module('translation.pages.programmer-view', [
  'ui.router'
  'ngCookies'
  'data-table'
  'ngMessages'
  'lbServices'
  'translation.providers.userPermissionsSettings'
  'ui.bootstrap'
])

.config ($stateProvider, UserPermissionsSettingsProvider) ->

  access = UserPermissionsSettingsProvider.accessLevels

  $stateProvider.state 'app.programmer-view',
    url:            '/programmer-view'
    controller:     'ProgrammerViewController'
    controllerAs:   'vm'
    templateUrl:    'programmer-view/programmer-view.tpl.html'
    data:
      access:       access.user

.controller 'ProgrammerViewController', ($log, $cookies, $timeout, TranslationKey, $uibModal) ->

  vm              = this
  vm.query        = ""
  vm.filters      = {}
  vm.contextMenu  = {}
  vm.tableData    = []

  $timeout () ->
    vm.contextMenu.name   = "Programmer"
    vm.contextMenu.links  = [
      {
        name: "Export selected to..."
        method: "exportSelectedTo()"
      }
    ]
    return

  TranslationKey.find(
    filter:
      include: [
        "translations": [
          "language"
          "modifiedBy"
        ]
        "project"
        "namespace"
      ]
  ).$promise.then (success)->
    vm.tableData = success
    vm.displayedCollection = [].concat(vm.tableData)
  , (error) ->
    console.log "Problem with loading translation keys"



  vm.open = ->
    $uibModal.open(
      animation: true
      templateUrl: 'templates/dialog/translation.tpl.html'
      controller: 'ModalInstanceCtrl'
      controllerAs: 'vm'
      size: 'lg'
      windowClass: 'center-modal'
    )


  return vm


.controller 'ModalInstanceCtrl', ($uibModalInstance, TranslationKey) ->
  vm                          = this
  vm.currentKey               = {}
  vm.currentKey.keyString     = 'TESTOWY'
  vm.currentKey.isPlural      = false
  vm.currentKey.projectId     = 1
  vm.currentKey.namespaceId   = 3
  vm.ok = ->
    TranslationKey.create($scope.currentKey).$promise.then () ->
      console.log 'saving key!'
      $uibModalInstance.close()
    , (error) ->
      console.log 'error while saving key'

  vm.cancel = ->
    $uibModalInstance.close()

  return vm
