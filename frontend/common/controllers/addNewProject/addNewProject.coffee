# # AddNewProject

# @module       translation.controllers.addNewProject
angular.module('translation.controllers.addNewProject', [
  'ui.router'
  'pascalprecht.translate'
  'ngCookies'
  'data-table'
  'ngMessages'
  'ngAnimate'
  'lbServices'
  'toastr'
  'ui.bootstrap'
  'translation.providers.userPermissionsSettings'
  'translation.services.account'
  'translation.services.plural'
  'translation.directives.trWaitingSpinnerDiv'
])

# $scope is used only for emit
.controller 'AddNewProjectController', ($scope, $rootScope, $timeout, $filter,
$log, $q, toastr, $cookies, $uibModalInstance, Project, Namespace, Language,
ProjectLanguage) ->
  vm  = this

  _cookieName       = "tmpAddNewProject"
  _currentDate      = new Date()

  vm.isPending      = true
  vm.submitted      = false
  vm.languages      = []

  vm.formdata       = {}

  (_updateData = () ->
    Language.find().$promise.then (success) ->
      vm.languages = success
      vm.isPending = false
      return
    , (e) ->
      msg = $filter('translate')('APP.FRONTEND_MESSAGES.ERROR_OCCURED_WHILE_GETTING_LANGUAGES_DATA')
      toastr.error msg
      vm.isPending = false
      return
  )(@)


  # @public
  # @method       vm.saveNewProject
  # @description  Create a new project
  # @returns      {None}
  vm.saveNewProject = ->
    vm.submitted = true
    if $scope.addNewProjectForm.$valid
      Project.create(vm.formdata).$promise.then (projectResponse) ->
        console.log "projectResponse", projectResponse
        proLang =
          projectId:  projectResponse.id
          languageId: projectResponse.defaultLanguageId
        ProjectLanguage.upset(proLang).$promise.then (proLangResponse) ->
          console.log 'proLangResponse', proLangResponse
          msg = $filter('translate')('APP.FRONTEND_MESSAGES.ADD_NEW_PROJECT.PROJECT_CREATED_SUCCESSFULLY')
          toastr.success msg
          $rootScope.$emit 'reloadProjectsList'
          $uibModalInstance.close()
          return
        , (proLangError) ->
          console.log('Error:', proLangError)
          msg = $filter('translate')\
            ('APP.FRONTEND_MESSAGES.ADD_NEW_PROJECT.PROBLEM_OCCURED_WHILE_CREATING_PROJECT_LANGUAGE_ENTRY')
          toastr.error msg
          $uibModalInstance.close()
          return
      , (projectError) ->
        console.log('Error:', projectError)
        msg = $filter('translate')('APP.FRONTEND_MESSAGES.ADD_NEW_PROJECT.PROBLEM_OCCURED_WHILE_CREATING_NEW_PROJECT')
        toastr.error msg
        $uibModalInstance.close()
        return
      return


  # @public
  # @method       cancel
  # @description  Close modal of adding new project
  vm.cancel = ->
    $uibModalInstance.close()
    return


  # @public
  # @method       cleanForm
  # @description  Clean form of adding new project
  vm.cleanForm = ->
    vm.formdata   = {}
    vm.submitted  = false
    return

  return vm
