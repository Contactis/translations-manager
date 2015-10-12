angular.module('translation.pages.manager-view', [
  'ui.router'
  'data-table'
  'smart-table'
  'translation.providers.userPermissionsSettings'
  'restangular'
])


.config ($stateProvider, UserPermissionsSettingsProvider) ->

  access = UserPermissionsSettingsProvider.accessLevels

  $stateProvider.state 'app.manager-view',
    url:            '/manager-view'
    controller:     'ManagerViewController'
    templateUrl:    'manager-view/manager-view.tpl.html'
    data:
      access: access.user


.controller 'ManagerViewController', ($scope, $timeout, Restangular) ->
  $scope.filters = {}
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
#  $scope.tableData = {"id":1,"keyString":"LOGIN","isPlural":false,"projectId":1,"groupId":3,"Translations":[]}
  Restangular.one('translations-keys').getList().then (success)->
    $scope.tableData = success.plain()
    $scope.displayedCollection = [].concat($scope.tableData)
  , (error) ->
    console.log "Problem with loading translation keys"

  return

