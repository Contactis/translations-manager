angular.module('translation.pages.programmer-view', [
  'ui.router'
  'ngCookies'
  'ngMaterial'
])

.config ($stateProvider) ->

  $stateProvider.state 'app.programmer-view',
    url:            '/programmer-view'
    controller:     'ProgrammerViewController'
    templateUrl:    'programmer-view/programmer-view.tpl.html'

.controller 'ProgrammerViewController', ($scope, $log, $cookies, $mdSidenav, $mdUtil) ->
  console.log "ProgrammerViewController !!!"

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


