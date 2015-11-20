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
    data:
      access: access.user


.controller 'ChooseProjectController', ($state, toastr, Project, CurrentProjectService) ->

  vm = this

  Project.find().$promise.then (response) ->
    vm.projects = response


  vm.chooseProject = (projectId) ->
    CurrentProjectService.downloadCurrentProject(projectId).then ->
      $state.go 'app.manager.dashboard'
    , (error) ->
      toastr.warning error




  return vm
