translationApp = angular.module('translation', [
  # Including external libraries
  'ui.router'
  'pascalprecht.translate'
  'restangular'
  'ngAnimate'
  'ngAria'
  'ngMaterial'

  # Including templates
  'templates-module'

# Including pages of aplication
  'translation.404'
  'translation.home'
  'translation.login'
  'translation.register'
  'translation.dashboard'
])


.config ($stateProvider, $urlRouterProvider, $locationProvider) ->

  $stateProvider
  .state 'app',
    url:          ''
    abstract:     true
    controller:   'AppController'
    templateUrl:  'templates/app.tpl.html'

  $urlRouterProvider
    .when('', '/')
    .when('/', '/home')
    .otherwise('/404')



  $locationProvider.html5Mode(true)


.run ($rootScope) ->

  $rootScope.$on '$stateChangeStart', (event, toState, toParams, fromState, fromParams) ->
    return

  $rootScope.$on '$stateChangeError', (event, toState, toParams, fromState, fromParams, error) ->
    return

  $rootScope.$on '$stateChangeSuccess', (event, toState, toParams, fromState, fromParams) ->
    return

  return

# App Controller
# -------------
.controller 'AppController', ($scope) ->
  return

