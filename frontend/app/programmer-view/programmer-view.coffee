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

  $stateProvider.state 'app.programmer-view',
    url:            '/programmer-view'
    controller:     'ProgrammerViewController'
    controllerAs:   'vm'
    templateUrl:    'programmer-view/programmer-view.tpl.html'
    data:
      access:       access.user

.controller 'ProgrammerViewController', ($log, $cookies, $timeout, TranslationKey, $uibModal, Namespace, $http) ->

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
      controller: 'TranslationModalController'
      controllerAs: 'vm'
      size: 'lg'
      windowClass: 'center-modal'
    )

  return vm



