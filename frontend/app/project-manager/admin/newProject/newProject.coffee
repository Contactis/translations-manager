angular.module('translation.pages.admin.new-project', [
  'ui.router'
  'pascalprecht.translate'
  'ngCookies'
  'data-table'
  'toastr'
  'lbServices'
  'ui.bootstrap'
])
.config ($stateProvider, UserPermissionsSettingsProvider) ->

  access = UserPermissionsSettingsProvider.accessLevels

  $stateProvider.state 'app.admin.new-project',
    url:            '/new-project'
    controller:     'NewProjectController'
    controllerAs:   'vm'
    templateUrl:    'project-manager/admin/newProject/newProject.tpl.html'
    data:
      access:       access.admin
    resolve:
      ProjectsResolver: (Project) ->
        return Project.find
          filter:
            include: [
              "defaultLanguage"
            ]
        .$promise
      CurrentProjectResolver:  (CurrentProjectService) ->
        return CurrentProjectService.getCurrentProject()

.controller 'NewProjectController', ($rootScope, $filter,
CurrentProjectResolver, ProjectsResolver, Project, ProjectLanguage, $uibModal) ->
  vm = this

  vm.currentProject = CurrentProjectResolver
  vm.projects = ProjectsResolver

  vm.addNewProject = () ->
    $uibModal.open
      animation:    true
      templateUrl:  'templates/dialog/addNewProject.tpl.html'
      controller:   'AddNewProjectController'
      controllerAs: 'vm'
      size:         'lg'
      windowClass:  'center-modal'


  _updateProjectsList = () ->
    Project.find().$promise.then (projectsResponse) ->
      vm.projects = projectsResponse
      return
    , (projectsError) ->
      msg = $filter('translate')('APP.FRONTEND_MESSAGES.ERROR_OCCURED_WHILE_GETTING_PROJECTS_DATA')
      toastr.error msg
      return
    return

  vm.deleteProject = (index) ->
    _id = vm.projects[index].id
    console.log(_id)
    Project.deleteById({id: _id}).$promise.then (projectDeleteResponse) ->
      console.log "projectDeleteResponse", projectDeleteResponse
      ProjectLanguage.find
        where:
          projectId: _id
      .$promise.then (proLangResponse) ->
        console.log 'proLangResponse', proLangResponse
        ProjectLanguage.deleteById({id: proLangResponse.id}).$promise.then (proLangDeleteResponse) ->
          console.log 'proLangDeleteResponse', proLangDeleteResponse
          msg = $filter('translate')('APP.FRONTEND_MESSAGES.NEW_PROJECT.PROJECT_REMOVED_SUCCESSFULLY')
          toastr.error msg
          _updateProjectsList()
          return
        , (proLangDeleteError) ->
          console.log('Cannot remove ProjectLanguage entry', proLangDeleteError)
          return
      , (proLangError) ->
        console.log('Cannot get ProjectLanguage entry', proLangError)
        return
      return
    , (projectDeleteError) ->
      msg = $filter('translate')('APP.FRONTEND_MESSAGES.NEW_PROJECT.ERROR_OCCURED_WHILE_REMOVING_PROJECT')
      toastr.error msg
      console.log 'Error: ', projectDeleteError
      return
    return


  $rootScope.$on 'reloadProjectsList', (event, data) ->
    console.log 'reloadProjectsList', data
    _updateProjectsList()


  return vm
