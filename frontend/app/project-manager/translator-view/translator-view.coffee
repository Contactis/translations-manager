angular.module('translation.pages.translator-view', [
  'translation.providers.userPermissionsSettings'
  'translator.directive.trEditTable'
  'ui.router'
  'ngCookies'
  'data-table'
  'ngMessages'
  'ngAnimate'
  'lbServices'
  'ui.bootstrap'
])

.config ($stateProvider, UserPermissionsSettingsProvider) ->

  access = UserPermissionsSettingsProvider.accessLevels

  $stateProvider.state 'app.manager.translator-view',
    url:            '/translator-view'
    controller:     'TranslatorViewController'
    controllerAs:   'vm'
    templateUrl:    'project-manager/translator-view/translator-view.tpl.html'
    data:
      access:       access.user
    resolve:
      currentProject: (CurrentProjectService) ->
        return CurrentProjectService.getCurrentProject()
      languageList: (LanguageService, currentProject) ->
        #TODO asd
        return LanguageService.getAllTranslationsForProject(currentProject.id)

.controller 'TranslatorViewController', (TranslationKey, LanguageService, Translation, languageList, currentProject) ->


  vm              = this
  vm.query        = ""
  vm.filters      = {}
  vm.contextMenu  = {}
  vm.tableData    = []

  _langList = languageList.result
  vm.translateLanguage  = LanguageService.getTranslateLanguage(_langList, currentProject.defaultLanguageId)
  vm.allLanguages       = _langList

  vm.updateLanguage = (lang) ->
    LanguageService.setTranslationLanguageId(lang.id)
    _fetchData()


  _fetchData = ->
    _defaultLanguageId = currentProject.defaultLanguageId
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
                  {languageId:_defaultLanguageId},
                  {languageId:LanguageService.getTranslationLanguageIdOrFind(_defaultLanguageId, _langList)}
                ]
          }
        ]
        where:
          projectId: currentProject.id
    .$promise.then (success)->
      vm.tableData = success
      vm.displayedCollection = [].concat(vm.tableData)
    , (error) ->
      console.log 'Problem with loading translation keys', error

  _fetchData()

  vm.deleteTranslation = (itemIndex) ->
    if vm.displayedCollection[itemIndex].translations[1] is undefined
    else
      _translationId = vm.displayedCollection[itemIndex].translations[1].id
      if _translationId is undefined
      else
        Translation.deleteById { id:_translationId }
        .$promise.then () ->
          delete vm.displayedCollection[itemIndex].translations[1]


  return vm



