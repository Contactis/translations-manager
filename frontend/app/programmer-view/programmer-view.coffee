angular.module('translation.pages.programmer-view', [
  'ui.router'
  'ngCookies'
  'ngMaterial'
  'data-table'
  'ngMessages'
  'restangular'
  'translation.providers.userPermissionsSettings'
])

.config ($stateProvider, UserPermissionsSettingsProvider) ->

  access = UserPermissionsSettingsProvider.accessLevels

  $stateProvider.state 'app.programmer-view',
    url:            '/programmer-view'
    controller:     'ProgrammerViewController'
    templateUrl:    'programmer-view/programmer-view.tpl.html'
    data:
      access:       access.user

.controller 'ProgrammerViewController', ($scope, $log, $cookies, $timeout, $mdSidenav,
$mdUtil, Restangular, $mdDialog) ->

  $scope.filters     = {}
  $scope.contextMenu = {}
  $scope.tableData  = []

  $timeout () ->
    $scope.contextMenu.name   = "Programmer"
    $scope.contextMenu.links  = [
      {
        name: "Export selected to..."
        method: "exportSelectedTo()"
      }
    ]
    return


  Restangular.one('translations-keys').getList().then (success)->
    $scope.tableData = success.plain()
    console.log success
  , (error) ->
    console.log "Problem with loading translation keys"

  # @private
  _exportSelectedTo = () ->
    console.log "exportSelectedTo fired"


  # @public
  $scope.toogleSidenav = (componentId) ->
    $mdSidenav(componentId)
      .toggle()
      .then( () ->
        $log.debug('toggled')
      )


  $scope.toggleSidenav = () ->
    $mdSidenav(menu).close().then () ->
      $log.debug("close LEFT is done")


  $scope.options =
    rowHeight:          50
    headerHeight:       40
    footerHeight:       false
    scrollbarV:         true
    checkboxSelection:  true
    selectable:         true
    multiSelect:        true
    emptyMessage:       'Nothing to show...',
    columnMode:         'force'
    columns: [
# {
#   name: "Database ID"
#   prop: "id"
#   width: 10
# }
      {
        name: "Index key name"
        prop: "keyString"
        isCheckboxColumn: true,
        headerCheckbox: true
      }
      {
        name: "Default translation - English(en-US)"
        prop: "translation"
      }
      {
        name: "Context description"
        prop: "gender"
      }
    ]




  $scope.showAdvanced = (ev) ->
    $mdDialog.show
      controller: DialogController
      templateUrl: "templates/dialog/translation.tpl.html"
      parent: angular.element(document.body)
      targetEvent: ev
      clickOutsideToClose: true

  DialogController = ($scope, $mdDialog) ->
    $scope.currentKey = {}
    $scope.currentKey.isPlural = true
    $scope.closeDialog = () ->
      $mdDialog.hide()

    $scope.saveKey = () ->
      console.log 'saving key!'

    #mocked
    $scope.languagePlurals = [
      { plural: "One",   example: ": 1"}
      { plural: "Other", example: ": 0, 2-999, 12..."}
    ]
  DialogController.$inject = ["$scope", "$mdDialog"]

  return
