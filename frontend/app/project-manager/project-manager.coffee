translationApp = angular.module('translation.pages.manager', [
  'translation.services.current-project'
])
.config ($stateProvider) ->

  $stateProvider
  .state 'app.manager',
    url:          '/manager'
    replace:      true
    abstract:     true
    controller:   'ManagerController'
    controllerAs: 'vm'
    template:     '<div ui-view=""></div>'
    resolve:
      currentProject: (CurrentProjectService) ->
        return CurrentProjectService.getProjectContext()


# App Controller
# -------------
.controller 'ManagerController', (CurrentProjectService) ->

  vm = this

  console.log CurrentProjectService


  return vm
