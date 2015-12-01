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

.controller 'TranslatorViewController', (TranslationKey, LanguageService, languageList, currentProject) ->


  vm              = this
  vm.query        = ""
  vm.filters      = {}
  vm.contextMenu  = {}
  vm.tableData    = []

  _langList = languageList.result
  vm.translateLanguage  = LanguageService.getTranslateLanguage(_langList)
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
  return vm



