angular.module('translation.pages.translator-view', [
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

  $stateProvider.state 'app.manager.translator-view',
    url:            '/translator-view'
    controller:     'TranslatorViewController'
    controllerAs:   'vm'
    templateUrl:    'project-manager/translator-view/translator-view.tpl.html'
    data:
      access:       access.user

.controller 'TranslatorViewController', ($log, $cookies, $timeout, TranslationKey, $uibModal, Namespace, $http) ->

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



