# # Project Settings (admin)

# @module   translation.pages.admin.project-settings
angular.module('translation.pages.admin.project-settings', [
  'pascalprecht.translate'
  'lbServices'
  'ngSanitize'
  'ui.select'
  'toastr'
])


.config ($stateProvider, UserPermissionsSettingsProvider) ->

  access = UserPermissionsSettingsProvider.accessLevels

  $stateProvider.state 'app.admin.project-settings',
    url:            '/project-settings'
    controller:     'ProjectSettingsController'
    controllerAs:   'vm'
    templateUrl:    'project-manager/admin/projectSettings/projectSettings.tpl.html'
    data:
      access:       access.manager
    resolve:
      PresentUsingProjectResolver:  (CurrentProjectService) ->
        return CurrentProjectService.getCurrentProject()
      AvailableLanguagesResolver:   (Language) ->
        return Language.find().$promise


# @package   ProjectSettingsController
.controller 'ProjectSettingsController', ($scope, $log, $filter, PresentUsingProjectResolver,
AvailableLanguagesResolver, Project, toastr) ->
  vm = this

  # @description Store state of sumitted form
  vm.submitted = false


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
  vm.availableLanguages = AvailableLanguagesResolver


  # @public
  # @variable     vm.availableLanguages.selected
  # @type         Object
  # @description  Currtent language object withdraw from `vm.availableLanguages`
  #               to provide proper object selection from ui-select
  vm.availableLanguages.selected = _.where(vm.availableLanguages, {id: vm.currentProject.defaultLanguageId})[0]


  # @public
  # @method       vm.setSelectedLanguage
  # @param        {Object}  languageItem    full language item from `vm.availableLanguages`
  # @description  Sets proper language ID for `vm.currentProject` object
  vm.setSelectedLanguage = (languageItem) ->
    vm.currentProject.defaultLanguageId = languageItem.id

  # @public
  # @variable     vm.vars
  # @type         Object
  # @description  Sample examples of strings variables to show live view on
  #               page.
  vm.vars =
    first_namespace:    "first namespace"
    second_namespace:   "second Namespace"
    key_index_string:   "key indEx_strRinG"


  # @public
  # @variable     vm.settings
  # @type         Object
  # @description  Project settings variables (not saved on backend)
  vm.settings =
    data_and_time:
      display_formats:
        europe: "DD.MM.YYYY, hh:mm:ss"
        us:     "MM/DD/YYYY, hh:mm:ss"
    workflow:
      namespace:
        separator: "."
        separators_list: [
          "."
          "-"
          "_"
          ">"
        ]


  # @public
  # @variable     vm.examples
  # @description  Examples of live reload full keyindex strings
  # @returns      {String}
  vm.examples =
    one: ->
      return vm.vars.first_namespace + vm.settings.workflow.namespace.separator + \
      vm.vars.second_namespace + vm.settings.workflow.namespace.separator + \
      vm.vars.key_index_string


  # @public
  # @variable     vm.outputCaseTypes
  # @type         {Array}
  # @description  Types of stings cases
  vm.outputCaseTypes = [
    {
      name: "Orginal"
      type: 0
    }
    {
      name: "snake_case"
      type: 1
    }
    {
      name: "lowerCamelCase"
      type: 2
    }
    {
      name: "UpperCamelCase"
      type: 3
    }
    {
      name: "lowerCase"
      type: 4
    }
    {
      name: "UpperCase"
      type: 5
    }
  ]


  # @public
  # @method       vm.saveAbout
  # @description  Save about data for current used project.
  # @returns      {Promise}
  vm.saveAbout = ->
    vm.submitted = true
    if $scope.updateProjectForm.$valid
      vm.currentProject.$save().then (success) ->
        msg = $filter('translate')('APP.FRONTEND_MESSAGES.SUCCESSFULLY_SAVED_THE_DATA')
        toastr.success msg
        vm.submitted = false
        return true
      , (e) ->
        msg = $filter('translate')('APP.FRONTEND_MESSAGES.ERROR_OCCURED_WHILE_SAVING_THE_DATA') +
          ' ' + $filter('translate')('APP.FRONTEND_MESSAGES.TRY_AGAIN_LATER') +
          ' Error detail:' + e
        toastr.error msg
        vm.submitted = false
        return false

  return vm
