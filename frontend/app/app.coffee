translationApp = angular.module('translation', [
  # Including external libraries
  'ui.router'
  'pascalprecht.translate'
  'tmh.dynamicLocale'
  'restangular'
  'ngAnimate'
  'ngAria'
  'ui.bootstrap'
  'ngMessages'
  'smart-table'
  'angular-lodash'
  'toastr'

  # Including templates
  'templates-module'

  # Including directives
  'translation.directives.accessLevel'
  'translation.directive.searchWatchModel'

  # Including pages of aplication
  'translation.pages.404'
  'translation.pages.login'
  'translation.pages.choose-project'
  'translation.pages.dashboard'
  'translation.pages.manager-view'
  'translation.pages.programmer-view'
  'translation.pages.translator-view'
  'translation.pages.manager'
  'translation.pages.admin'
  'translation.pages.admin.project-settings'
  'translation.pages.admin.user-assignment'
  'translation.pages.admin.user-assignment'

  #
  # Including modules
  'translation.modules.languages'

  # Including services
  'translation.services.account'
  'translation.services.authorization'
  'translation.services.filtersState'
  'translation.services.customTranslationHandler'
  'translation.services.current-project'
  'translation.services.helper'

  # Including controllers
  'translation.controllers.sidenav'
  'translation.controllers.translationModal'

  # Including directives
  'translator.directive.trDashboardTop'
  'translator.directive.trEditTable'
])

.config ($stateProvider, $urlRouterProvider, $locationProvider, $animateProvider,
$translateProvider, tmhDynamicLocaleProvider, RestangularProvider, toastrConfig) ->

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

  $animateProvider.classNameFilter(/animate/)

  angular.extend toastrConfig,
    positionClass: 'toast-bottom-right'

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
    'pl-pl'
  ], {
    'en_US':  'en-us'
    'en-en':  'en-us'
    'en':     'en-us' # NOTE: change/remove if international version will be added
    'pl_PL':  'pl-pl'
    'pl':     'pl-pl'
  }).determinePreferredLanguage()

  $translateProvider.useSanitizeValueStrategy(null)

  # configure loading angular locales
  tmhDynamicLocaleProvider.localeLocationPattern('assets/angular-i18n/angular-locale_{{locale}}.js')

# Run
# ---
.run ($rootScope, $window, AccountService, AuthorizationService) ->
  _firstEnter   = true
  _firstSuccess = false

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
    if !_firstSuccess
      appSetup()
      _firstSuccess = true

    return


  return

# App Controller
# -------------
.controller 'AppController', ($scope, $rootScope, $state, $cookies, LanguagesService, AccountService) ->

  # Set language for income user (not logged in)
  LanguagesService.setLanguage(LanguagesService.getStartupLanguage())

  # Watch
  $scope.$watch () ->
    return AccountService.getAllData() # It should watch for whole object to track changes
  , (newVal, oldVal) ->
    # update user interface language if exsists and whole object user has been changed.
    if newVal.interfaceLanguage then LanguagesService.setLanguage(newVal.interfaceLanguage)
    return
  , true
  return

