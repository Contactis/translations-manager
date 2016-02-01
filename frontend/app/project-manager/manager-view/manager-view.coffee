angular.module('translation.pages.manager-view', [
  'ui.router'
  'lbServices'
  'data-table'
  'smart-table'
  'translation.providers.userPermissionsSettings'
  'translation.directive.searchWatchModel'
])


.config ($stateProvider, UserPermissionsSettingsProvider) ->

  access = UserPermissionsSettingsProvider.accessLevels

  $stateProvider.state 'app.manager.manager-view',
    url:            '/manager-view'
    controller:     'ManagerViewController'
    controllerAs:   'vm'
    templateUrl:    'project-manager/manager-view/manager-view.tpl.html'
    data:
      access: access.manager


.controller 'ManagerViewController', ($timeout, TranslationKey) ->
  vm              = this
  vm.filters      = {}
  vm.query        = ""
  vm.languageList = ['pl','en','de']
  vm.contextMenu  = {}
  vm.tableData    = []


  $timeout () ->
    vm.contextMenu.name   = "Manager"
    vm.contextMenu.links  = [
      {
        name: "Export selected to..."
        method: "exportSelectedTo()"
      }
    ]
    return

  TranslationKey.find().$promise.then (success)->
    vm.tableData = success
    vm.displayedCollection = [].concat(vm.tableData)
  , (error) ->
    console.log "Problem with loading translation keys"

  return vm

