angular.module('translation.pages.translator-view', [
  'ui.router'
  'ngCookies'
  'data-table'
  'ngMessages'
  'ngAnimate'
  'ui.select'
  'ngSanitize'
  'lbServices'
  'ui.bootstrap'
  'toastr'

  'translation.providers.userPermissionsSettings'
  'translation.directives.trEditTable'
  'translation.directives.trWaitingSpinnerSpan'
])

.config ($stateProvider, UserPermissionsSettingsProvider) ->

  access = UserPermissionsSettingsProvider.accessLevels

  $stateProvider.state 'app.manager.translator-view',
    url:            '/translator-view'
    controller:     'TranslatorViewController'
    controllerAs:   'vm'
    templateUrl:    'project-manager/translator-view/translator-view.tpl.html'
    data:
      access:       access.translator
    resolve:
      CurrentProjectResolver: (CurrentProjectService) ->
        return CurrentProjectService.getCurrentProject()
      LanguageListResolver: (LanguageService, CurrentProjectResolver) ->
        return LanguageService.getAllTranslationsForProject(CurrentProjectResolver.id)
#      NamespacesResolver: (Namespace, CurrentProjectResolver) ->
#        return Namespace.find
#          filter:
#            where:
#              projectId: CurrentProjectResolver.id
#        .$promise


.controller 'TranslatorViewController', ($log, TranslationKey, LanguageService, Translation,
toastr, UserPermissionsSettings, LanguageListResolver, CurrentProjectResolver) ->

  vm                  = this
  vm.query            = ""
  vm.filters          = {}
  vm.contextMenu      = {}
  vm.tableData        = []

  vm.isPending        = true
  vm.accessLevels     = UserPermissionsSettings.accessLevels
  vm.currentProject   = CurrentProjectResolver
#  vm.projectNamespaces = NamespacesResolver

  _langList = LanguageListResolver.result
  vm.translateLanguage  = LanguageService.getTranslateLanguage(_langList, vm.currentProject.defaultLanguageId)
  vm.allLanguages       = _langList
  if vm.translateLanguage is undefined
    vm.translateLanguage = vm.allLanguages[0]


  (_fetchData = ->
    vm.isPending        = true
    _defaultLanguageId  = vm.currentProject.defaultLanguageId
    TranslationKey.find
      filter:
        include:[
          {
            relation: 'namespace'
          }
          {
            relation: 'translations'
            scope:
              where:
                or:[
                  {languageId: _defaultLanguageId},
                  {languageId: LanguageService.getTranslationLanguageIdOrFind(_defaultLanguageId, _langList)}
                ]
          }
        ]
        where:
          projectId: vm.currentProject.id
    .$promise.then (success) ->
      vm.tableData            = success
      vm.displayedCollection  = [].concat(vm.tableData)
      vm.isPending            = false
    , (error) ->
      $log.error 'Problem with loading translation keys', error
      vm.isPending        = false
  )(@)


  vm.isTranslationForDefaultLanguage = () ->
    return if vm.currentProject.defaultLanguageId is vm.translateLanguage.id then true else false


  vm.updateLanguage = (lang) ->
    LanguageService.setTranslationLanguageId(lang.id)
    _fetchData()

  vm.translateChooser = (singleRow) ->
    return _.find singleRow.translations, (element) ->
      return element.languageId == vm.translateLanguage.id

  vm.deleteTranslation = (translationObject) ->
#    fixme translation id mocked
    Translation.deleteById { id:translationObject.translations[0].id }
    .$promise.then (deleteTranslationResponse) ->
      _fetchData()
      toastr.success "Clear translation successfully"
    , (deleteTranslationError) ->
      toastr.success "Some problem occured while clearing translation"
      console.log "Error occured while clearing translation", deleteTranslationError

  return vm



