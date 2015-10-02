angular.module('translation.pages.programmer-view', [
  'ui.router'
  'ngCookies'
  'ngMaterial'
  'userPermissionsSettings'
  'data-table'
])

.config ($stateProvider, userPermissionsSettingsProvider) ->

  access = userPermissionsSettingsProvider.accessLevels

  $stateProvider.state 'app.programmer-view',
    url:            '/programmer-view'
    controller:     'ProgrammerViewController'
    templateUrl:    'programmer-view/programmer-view.tpl.html'
    data:
      access: access.user

.controller 'ProgrammerViewController', ($scope, $log, $cookies, $mdSidenav, $mdUtil) ->

  $scope.filter = {}

  # buildToggler = (navID) ->
  #   debounceFn = $mdUtil.debounce( () ->
  #     $mdSidenav(navID)
  #       .toggle()
  #       .then () ->
  #         $log.debug("toggle " + navID + " is done")

  #   , 200)
  #   return debounceFn

  # $scope.toogleLeft = () ->
  #   $mdSidenav()

  $scope.toogleSidenav = (componentId) ->
    $mdSidenav(componentId)
      .toggle()
      .then( () ->
        $log.debug('toggled')
      )


  $scope.toggleSidenav = () ->
    $mdSidenav(menu).close().then () ->
      $log.debug("close LEFT is done")
  return


