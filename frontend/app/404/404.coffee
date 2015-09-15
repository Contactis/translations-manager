angular.module('translation.404', [
  'ui.router'
])

.config ($stateProvider) ->

  $stateProvider.state '404',
    url:            '/404'
    controller:     'Page404Controller'
    templateUrl:    '404/404.tpl.html'

.controller 'Page404Controller', ($scope) ->

  return


