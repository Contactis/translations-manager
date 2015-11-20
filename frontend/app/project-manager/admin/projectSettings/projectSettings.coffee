# # Project Settins (admin)

# @module   translation.pages.admin.project-settings
angular.module('translation.pages.admin.project-settings', [
  'lbServices'
  'translation.services.current-project'
])


.config ($stateProvider, UserPermissionsSettingsProvider) ->

  access = UserPermissionsSettingsProvider.accessLevels

  $stateProvider.state 'app.admin.project-settings',
    url:            '/project-settings'
    controller:     'ProjectSettingsController'
    controllerAs:   'vm'
    templateUrl:    'project-manager/admin/projectSettings/projectSettings.tpl.html'
    data:
      access:       access.management
    resolve:
      PresentUsedProject: (CurrentProjectService) ->
        return CurrentProjectService.getCurrentProject()


# @package   ProjectSettingsController
.controller 'ProjectSettingsController', ($scope, $log, PresentUsedProject, Project) ->
  vm = this


  # @public
  # @variable     vm.currentProject
  # @type         Object
  # @description  Object with current project data returned in resolved promise.
  vm.currentProject = PresentUsedProject


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
    vm.currentProject.$save().then (success) ->
      $log.info "successfully saved"
      return true
    , (e) ->
      $log.error "saveing failed"
      return false

  return vm
