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


.controller 'ManagerViewController', ($scope, Restangular) ->
  $scope.filter = {}
  $scope.languageList = ['pl','en','de']

  Restangular.one('translations-keys').getList().then (success)->
    $scope.tableData = success.plain()
    console.log success
  , (error) ->
    console.log "Problem with loading translation keys"


  return

