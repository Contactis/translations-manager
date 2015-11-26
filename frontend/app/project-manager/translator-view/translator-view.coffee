angular.module('translation.pages.translator-view', [
  'translation.providers.userPermissionsSettings'
  'translator.directive.trEditTable'
  'ui.router'
  'ngCookies'
  'data-table'
  'ngMessages'
  'ngAnimate'
  'lbServices'
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

.controller 'TranslatorViewController', ($log, $cookies, $timeout, TranslationKey, Translation,
$uibModal, Namespace, $http, CurrentProjectService) ->

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
  CurrentProjectService.getCurrentProject().then (response) ->

    TranslationKey.find(
      filter:
        include:[
          {
            relation: 'namespace'
          }
          {
            relation: 'translations'
            scope:
              where:
                or:[{languageId:response.defaultLanguageId}, {languageId:3}]
          }
        ]
        where:
          projectId: response.id
    ).$promise.then (success)->
      vm.tableData = success
      vm.displayedCollection = [].concat(vm.tableData)
    , (error) ->
      console.log "Problem with loading translation keys"
  , (error) ->
    console.log 'something went wrong!', error

  return vm



