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
    templateUrl:    'programmer-view/programmer-view.tpl.html'
    data:
      access:       access.user

.controller 'ProgrammerViewController', ($scope, $log, $cookies, $timeout, TranslationKey, $uibModal) ->

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
    $scope.tableData = success
    $scope.displayedCollection = [].concat($scope.tableData)
  , (error) ->
    console.log "Problem with loading translation keys"



  $scope.open = ->
    modalInstance = $uibModal.open(
      animation: true
      templateUrl: 'templates/dialog/translation.tpl.html'
      controller: 'ModalInstanceCtrl'
      size: 'lg'
      windowClass: 'center-modal'
    )


  return


.controller 'ModalInstanceCtrl', ($scope, $uibModalInstance, TranslationKey) ->
  $scope.currentKey   = {}
  $scope.currentKey.keyString     = 'TESTOWY'
  $scope.currentKey.isPlural      = false
  $scope.currentKey.projectId     = 1
  $scope.currentKey.namespaceId   = 3
  $scope.ok = ->
    TranslationKey.create($scope.currentKey).$promise.then () ->
      console.log 'saving key!'
      $uibModalInstance.close()
    , (error) ->
      console.log 'error while saving key'

  $scope.cancel = ->
    $uibModalInstance.close()
