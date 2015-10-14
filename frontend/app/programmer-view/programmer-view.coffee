angular.module('translation.pages.programmer-view', [
  'ui.router'
  'ngCookies'
  'ngMaterial'
  'data-table'
  'ngMessages'
  'lbServices'
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
$mdUtil, TranslationKey, $mdDialog) ->

  $scope.query = ""
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


  TranslationKey.find().$promise.then (success)->
    $scope.tableData = success
    $scope.displayedCollection = [].concat($scope.tableData)
  , (error) ->
    console.log "Problem with loading translation keys"




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
      sample =
      {
        'keyString': 'LOGIN_KUBY'
        'isPlural': false
        'projectId': 1
        'groupId': 3
      }
      TranslationKey.create(sample).$promise.then () ->
        console.log 'saving key!'
      , (error) ->
        console.log 'error while saving key'

    #mocked
    $scope.languagePlurals = [
      { plural: "One",   example: ": 1"}
      { plural: "Other", example: ": 0, 2-999, 12..."}
    ]
  DialogController.$inject = ["$scope", "$mdDialog"]

  return
