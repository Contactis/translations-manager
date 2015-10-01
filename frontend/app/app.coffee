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
  'translation.login'
  'translation.dashboard'
  'translation.manager-view'
  'translation.programmer-view'

  # Including services
  'userService'
  'authorizationService'

  # Including controllers
  'translation.controllers.sidenav'
])


.config ($stateProvider, $urlRouterProvider, $locationProvider, $animateProvider, RestangularProvider,
$mdThemingProvider) ->

  $stateProvider
  .state 'app',
    url:          ''
    abstract:     true
    controller:   'AppController'
    templateUrl:  'templates/app.tpl.html'
    resolve:
      user: (userService) ->
        return userService.getSession()

  $urlRouterProvider
    .when('', '/')
    .when('/', '/login')
    .otherwise('/404')



  RestangularProvider.setBaseUrl '/api'

  $locationProvider.html5Mode(true)

  #$animateProvider.classNameFilter(/animate/)

  $mdThemingProvider.theme('default')
    .primaryPalette('blue-grey')
    .accentPalette('pink')


.run ($rootScope, authorization, userService) ->


  _firstEnter = {}

  userService.getSession().then () ->
    authorization.accessCheck(_firstEnter.event, _firstEnter.toState)

  $rootScope.$on '$stateChangeStart', (event, toState, toParams, fromState, fromParams) ->

    if _.isEmpty _firstEnter
      _firstEnter.event = event
      _firstEnter.toState = toState
    else
      authorization.accessCheck(event, toState)
    return

  $rootScope.$on '$stateChangeError', (event, toState, toParams, fromState, fromParams, error) ->
    console.log error
    return

  $rootScope.$on '$stateChangeSuccess', (event, toState, toParams, fromState, fromParams) ->
    return

  return

# App Controller
# -------------
.controller 'AppController', ($scope, $rootScope, $state, $cookies, $mdSidenav) ->

  return

