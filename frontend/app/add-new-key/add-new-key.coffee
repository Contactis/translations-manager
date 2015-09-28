angular.module('translation.add-new-key', [
  'ui.router'
  'ngCookies'
  'ngMaterial'
])

.config ($stateProvider) ->

  $stateProvider.state 'app.add-new-key',
    url:            '/add-new-key'
    controller:     'AddNewKeyController'
    templateUrl:    'add-new-key/add-new-key.tpl.html'
    # parent:         'app'

.controller 'AddNewKeyController', ($scope, $cookies) ->
  console.log "AddNewKeyController !!!"

  $scope.close = () ->
    $mdSidenav('left').close().then( ()->
      $log.debug("close LEFT is done")
  return


