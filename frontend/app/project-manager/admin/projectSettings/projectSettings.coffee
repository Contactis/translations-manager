angular.module('translation.pages.admin.project-settings', [
  'lbServices'
  'translation.services.projects'
])


.config ($stateProvider, UserPermissionsSettingsProvider) ->

  access = UserPermissionsSettingsProvider.accessLevels

  $stateProvider.state 'app.admin.project-settings',
    url:            '/project-settings'
    controller:     'ProjectSettingsController'
    controllerAs:   'vm'
    templateUrl:    'admin/projectSettings/projectSettings.tpl.html'
    data:
      access:       access.management


.controller 'ProjectSettingsController', ($scope, $log, ProjectsService) ->
  vm = this

  vm.currentProject =
    "name": "Translation manager"
    "defaultLanguageId": 1
    "description": "This is dummy description for translation manager"
    "id": 1

  vm.vars =
    first_namespace:    "first namespace"
    second_namespace:   "second Namespace"
    key_index_string:   "key indEx_strRinG"

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

  vm.examples =
    one: ->
      return vm.vars.first_namespace + vm.settings.workflow.namespace.separator + \
      vm.vars.second_namespace + vm.settings.workflow.namespace.separator + \
      vm.vars.key_index_string

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


  return vm
