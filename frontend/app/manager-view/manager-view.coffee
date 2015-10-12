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


  $timeout () ->
    $scope.contextMenu.name   = "Manager"
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
    console.log success[0].keyString
  , (error) ->
    console.log "Problem with loading translation keys"


  return

