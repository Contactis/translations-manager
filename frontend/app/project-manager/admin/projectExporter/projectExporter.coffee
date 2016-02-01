# # Export Settings (admin)

# @module   translation.pages.admin.export-project
angular.module('translation.pages.admin.project-exporter', [
  'pascalprecht.translate'
  'lbServices'
  'ngSanitize'
  'ui.select'
  'toastr'
  'lodash'
])


.config ($stateProvider, UserPermissionsSettingsProvider) ->

  access = UserPermissionsSettingsProvider.accessLevels

  $stateProvider.state 'app.admin.project-exporter',
    url:            '/project-exporter'
    controller:     'ProjectExporterController'
    controllerAs:   'vm'
    templateUrl:    'project-manager/admin/projectExporter/projectExporter.tpl.html'
    data:
      access:       access.programmer
    resolve:
      PresentUsingProjectResolver:  (CurrentProjectService) ->
        return CurrentProjectService.getCurrentProject()
      LanguagesList: (LanguageService, PresentUsingProjectResolver) ->
        return LanguageService.getAllTranslationsForProject(PresentUsingProjectResolver.id)


# @package   ProjectSettingsController
.controller 'ProjectExporterController', ($scope, $log, $filter, PresentUsingProjectResolver,
LanguagesList, Project, Translation, toastr, _) ->
  vm = this


  # @public
  # @variable     vm.currentProject
  # @type         Object
  # @description  Object with current project data returned as resolved promise.
  vm.currentProject       = PresentUsingProjectResolver


  # @public
  # @variable     vm.availableLanguages
  # @type         Array
  # @description  List with current languages avaiable to choose for projects
  #               returned as resolved promise.
  vm.languagesList = LanguagesList.result


  # @public
  # @variable     vm.availableLanguages.selected
  # @type         Object
  # @description  Currtent language object withdraw from `vm.availableLanguages`
  #               to provide proper object selection from ui-select
  indexLang = _.findIndex vm.languagesList, (item) ->
    item.id == vm.currentProject.defaultLanguage.id
  vm.languagesList.selected = if indexLang then vm.languagesList[indexLang] else vm.languagesList[0]


  # @public
  # @method       vm.setSelectedLanguage
  # @param        {Object}  languageItem    full language item from `vm.availableLanguages`
  # @description  Sets proper language ID for `vm.currentProject` object
  vm.setSelectedLanguage = (languageItem) ->
    vm.currentProject.defaultLanguageId = languageItem.id


  # @public
  # @method       vm.saveAbout
  # @description  Save about data for current used project.
  # @returns      {Promise}
  vm.export = ->

    k =
      projectId: vm.currentProject.id
      projectLanguageId:vm.languagesList.selected.id
    Translation.export(k).$promise.then (success) ->
      vm.exportedText = success
      msg = $filter('translate')('APP.FRONTEND_MESSAGES.PROJECT_EXPORTER.SUCCESSFULLY_GENERATE_LIST')
      toastr.success msg
      return true
    , (e) ->
      #msg = $filter('translate')('APP.FRONTEND_MESSAGES.ERROR_OCCURED_WHILE_SAVING_THE_DATA') +
        #' ' + $filter('translate')('APP.FRONTEND_MESSAGES.TRY_AGAIN_LATER') +
        #' Error detail:' + e
      #toastr.error msg
      return false

  return vm
