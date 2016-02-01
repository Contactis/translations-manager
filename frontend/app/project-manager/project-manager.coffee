translationApp = angular.module('translation.pages.manager', [
  'translation.services.current-project'
])
.config ($stateProvider, UserPermissionsSettingsProvider) ->

  access = UserPermissionsSettingsProvider.accessLevels

  $stateProvider
  .state 'app.manager',
    url:          '/manager'
    replace:      true
    abstract:     true
    controller:   'ManagerController'
    controllerAs: 'vm'
    template:     '<div ui-view=""></div>'
    data:
      access:     access.manager
    resolve:
      currentProject: (CurrentProjectService) ->
        return CurrentProjectService.getProjectContext()


# App Controller
# -------------
.controller 'ManagerController', (CurrentProjectService) ->

  vm = this


  return vm
