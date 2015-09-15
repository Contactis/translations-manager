translationApp = angular.module('translation-manager', [

# Including templates
  'templates-module'


# Including pages of aplication
  'translation.login'
])

.config ($stateProvider) ->

  $stateProvider
  .state 'app',
    url: ''
    abstract: true
    controller:   'AppController'
    templateUrl:  'templates/app.tpl.html'
# App Controller
# -------------
.controller 'AppController', ($scope) ->
  console.log 'jestem'
