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
            where:
              isDeleted: 0
            include: [
              "defaultLanguage"
            ]
        .$promise
      CurrentProjectResolver:  (CurrentProjectService) ->
        return CurrentProjectService.getCurrentProject()

.controller 'NewProjectController', ($rootScope, $filter, toastr,
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
    return

  _updateProjectsList = () ->
    Project.find
      filter:
        where:
          isDeleted: 0
        include: [
          "defaultLanguage"
        ]
    .$promise.then (projectsResponse) ->
      vm.projects = projectsResponse
      return
    , (projectsError) ->
      msg = $filter('translate')('APP.FRONTEND_MESSAGES.ERROR_OCCURED_WHILE_GETTING_PROJECTS_DATA')
      toastr.error(msg)
      return
    return


  vm.deleteProject = (index) ->
    _id = vm.projects[index].id
    console.log(_id)
    _obj =
      id:         _id
      isDeleted:  1
    Project.upsert(_obj).$promise.then (projectUpdateResponse) ->
      # acctualty is not removed, only update isDeleted = true
      console.log 'projectUpdateResponse', projectUpdateResponse
      msg = $filter('translate')('APP.FRONTEND_MESSAGES.NEW_PROJECT.PROJECT_REMOVED_SUCCESSFULLY')
      toastr.success msg
      _updateProjectsList()
      return
    , (proLangDeleteError) ->
      console.log('Cannot remove project', proLangDeleteError)
      msg = $filter('translate')('APP.FRONTEND_MESSAGES.NEW_PROJECT.ERROR_OCCURED_WHILE_REMOVING_PROJECT')
      toastr.error msg
      return
    return


  $rootScope.$on 'reloadProjectsList', (event, data) ->
    console.log 'reloadProjectsList', data
    _updateProjectsList()
    return


  return vm
