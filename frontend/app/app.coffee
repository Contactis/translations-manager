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

  # Including directives
  'translation.directives.accessLevel'

  # Including pages of aplication
  'translation.pages.404'
  'translation.pages.login'
  'translation.pages.dashboard'
  'translation.pages.manager-view'
  'translation.pages.programmer-view'

  # Including services
  'translation.services.user'
  'translation.services.authorization'
  'translation.services.filtersState'

  # Including controllers
  'translation.controllers.sidenav'

  # Including directives
  'translator.directive.trTopBar'
])


.config ($stateProvider, $urlRouterProvider, $locationProvider, $animateProvider, RestangularProvider,
$mdThemingProvider) ->

  $stateProvider
  .state 'app',
    url:          ''
    replace:      true
    abstract:     true
    controller:   'AppController'
    templateUrl:  'templates/app.tpl.html'
    resolve:
      user: (UserService) ->
        return UserService.getSession()

  $urlRouterProvider
    .when('', '/')
    .when('/', '/login')
    .otherwise('/404')



  RestangularProvider.setBaseUrl '/api'

  $locationProvider.html5Mode(true)

  #$animateProvider.classNameFilter(/animate/)

  $mdThemingProvider.theme('default')
    .primaryPalette('blue-grey')
    .accentPalette('blue')
    .warnPalette('red')
    # .backgroundPalette('gray')


.run ($rootScope, UserService, AuthorizationService) ->


  _firstEnter = {}

  UserService.getSession().then () ->
    AuthorizationService.accessCheck(_firstEnter.event, _firstEnter.toState)


  $rootScope.$on '$stateChangeStart', (event, toState, toParams, fromState, fromParams) ->

    if _.isEmpty _firstEnter
      _firstEnter.event = event
      _firstEnter.toState = toState
    else
      AuthorizationService.accessCheck(event, toState)
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

