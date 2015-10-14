translationApp = angular.module('translation', [
  # Including external libraries
  'ui.router'
  'pascalprecht.translate'
  'tmh.dynamicLocale'
  'restangular'
  'ngAnimate'
  'ngAria'
  'ngMaterial'
  'ngMessages'
  'smart-table'
  'angular-lodash'

  # Including templates
  'templates-module'

  # Including directives
  'translation.directives.accessLevel'
  'translation.directive.searchWatchModel'

  # Including pages of aplication
  'translation.pages.404'
  'translation.pages.login'
  'translation.pages.dashboard'
  'translation.pages.manager-view'
  'translation.pages.programmer-view'
  #
  # Including modules
  'translation.modules.languages'

  # Including services
  'translation.services.account'
  'translation.services.authorization'
  'translation.services.filtersState'
  'translation.services.customTranslationHandler'

  # Including controllers
  'translation.controllers.sidenav'

  # Including directives
  'translator.directive.trTopBar'
])


.config ($stateProvider, $urlRouterProvider, $locationProvider, $animateProvider, $mdThemingProvider,
$translateProvider, tmhDynamicLocaleProvider, RestangularProvider) ->

  $stateProvider
  .state 'app',
    url:          ''
    replace:      true
    abstract:     true
    controller:   'AppController'
    templateUrl:  'templates/app.tpl.html'
    resolve:
      account: (AccountService) ->
        return AccountService.loadSession()
      getGroups: (FiltersStateService) ->
        return FiltersStateService.refreshGroups()
      InterfaceLanguagesResolver: (LanguagesService) ->
        return LanguagesService.getInterfaceLanguages()

  $urlRouterProvider
    .when('', '/')
    .when('/', '/login')
    .otherwise('/404')



  RestangularProvider.setBaseUrl '/api'

  #$locationProvider.html5Mode(true)

  #$animateProvider.classNameFilter(/animate/)

  ###
  The is some issue with defining backgroud color
  "Uncaught TypeError: Cannot read property '600' of undefined"
  More info: https://github.com/angular/material/issues/2752
  ###
  $mdThemingProvider
    .theme('default')
    .primaryPalette('blue-grey')
    .accentPalette('blue')
    .warnPalette('red')
    # .backgroundPalette('gray',
    #   'default': 'A200',
    #   'hue-1': '300',
    #   'hue-2': '600',
    #   'hue-3': '900'
    # )

  # ### Translations (angular translate)
  $translateProvider.addInterpolation('$translateMessageFormatInterpolation')

  # Warnings, regarding forgotten IDs in translations
  $translateProvider.useMissingTranslationHandler('CustomTranslationHandlerService')

  # Set a fallback language in case there find no other
  $translateProvider.fallbackLanguage('en-us')

  # **Set default language**
  # This method tries to resolve language by user locale
  $translateProvider.registerAvailableLanguageKeys([
    'en-us'
  ], {
    'en_US': 'en-us'
    'en-en': 'en-us'
    'en':    'en-us' # NOTE: change/remove if international version will be added
  }).determinePreferredLanguage()

  $translateProvider.useSanitizeValueStrategy(null)

  # configure loading angular locales
  tmhDynamicLocaleProvider.localeLocationPattern('assets/angular-i18n/angular-locale_{{locale}}.js')

# Run
# ---
.run ($rootScope, AccountService, AuthorizationService) ->
  _firstEnter = true

  $rootScope.$on '$stateChangeStart', (event, toState, toParams, fromState, fromParams) ->
    if _firstEnter
      _firstEnter = false
      AccountService.loadSession().then ->
        AuthorizationService.accessCheck event, toState
    else
      AuthorizationService.accessCheck event, toState
    return

  $rootScope.$on '$stateChangeError', (event, toState, toParams, fromState, fromParams, error) ->
    console.log '$stateChangeError', error
    return

  $rootScope.$on '$stateChangeSuccess', (event, toState, toParams, fromState, fromParams) ->
    return

  return

# App Controller
# -------------
.controller 'AppController', ($scope, $rootScope, $state, $cookies, $mdSidenav, LanguagesService, AccountService) ->

  console.log "AccountService.getData('interfaceLanguage')", AccountService.getData('interfaceLanguage')

  LanguagesService.getStartupLanguage().then (langCode) ->
    LanguagesService.setLanguage(langCode)

  # Watch
  $scope.$watch () ->
    return AccountService.getAllData()
  , (newVal, oldVal) ->
    # update user interface lang if exsist and has been changed
    if newVal.interfaceLanguage then LanguagesService.setLanguage(newVal.interfaceLanguage)
    return
  , true
  return

