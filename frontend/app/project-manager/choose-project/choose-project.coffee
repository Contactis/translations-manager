angular.module('translation.pages.choose-project', [
  'ui.router'
  'lbServices'
  'translation.services.current-project'
  'ui.router'
  'toastr'
])

.config ($stateProvider, UserPermissionsSettingsProvider) ->

  access = UserPermissionsSettingsProvider.accessLevels

  $stateProvider.state 'app.choose-project',
    url:            '/choose-project'
    controller:     'ChooseProjectController'
    controllerAs:   'vm'
    templateUrl:    'project-manager/choose-project/choose-project.tpl.html'
    resolve:
      projects: (Project) ->
        return Project.find().$promise
    data:
      access: access.user


.controller 'ChooseProjectController', ($state, toastr, projects, CurrentProjectService) ->

  vm = this

  vm.projects = projects


  vm.chooseProject = (projectId) ->
    CurrentProjectService.downloadCurrentProject(projectId).then ->
      $state.go 'app.manager.dashboard'
    , (error) ->
      toastr.warning error




  return vm
