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

  $stateProvider.state 'app.manager-view',
    url:            '/manager-view'
    controller:     'ManagerViewController'
    templateUrl:    'manager-view/manager-view.tpl.html'
    data:
      access: access.user


.controller 'ManagerViewController', ($scope, $timeout, TranslationKey) ->
  $scope.filters = {}
  $scope.query = ""
  $scope.languageList = ['pl','en','de']
  $scope.contextMenu = {}
  $scope.tableData = []


  $timeout () ->
    $scope.contextMenu.name   = "Manager"
    $scope.contextMenu.links  = [
      {
        name: "Export selected to..."
        method: "exportSelectedTo()"
      }
    ]
    return

  TranslationKey.find().$promise.then (success)->
    $scope.tableData = success
    $scope.displayedCollection = [].concat($scope.tableData)
  , (error) ->
    console.log "Problem with loading translation keys"

  return

