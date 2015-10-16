angular.module('translation.controllers.sidenav', [
  'ui.router'
  'ngAnimate'
  'ngCookies'
  'ngAria'
  'ngMaterial'
  'translation.services.projects'
  'translation.services.account'
  'translation.services.authorization'
  'translation.services.filtersState'
  'translation.directives.accessLevel'
  'translation.providers.userPermissionsSettings'
  'lbServices'
])


.controller 'SidenavController', ($scope, $rootScope, $state, $cookies, Account, FiltersStateService,
$mdSidenav, $mdUtil, ProjectsService, AccountService, AuthorizationService, UserPermissionsSettings) ->

  $scope.user = AccountService.account()
  $scope.user.loggedIn = Account.isAuthenticated()

  $scope.accessLevels = UserPermissionsSettings.accessLevels

  $scope.countLanguages = 8
  $scope.countKeys = 1234

  $scope.currentProject = {}

  ProjectsService.updated.then null, null, (project) ->
    $scope.currentProject = project

  AccountService.updated.then null, null, (user) ->
    $scope.user = user
    $scope.user.loggedIn = Account.isAuthenticated()


  $rootScope.logout = AuthorizationService.logout

  $scope.groups = FiltersStateService.getGroups()



  $rootScope.changeProject = () ->
    console.log "change project"



  # $scope.pages = [
  #   { name: 'Pepperoni', wanted: true }
  #   { name: 'Sausage', wanted: false }
  #   { name: 'Black Olives', wanted: true }
  #   { name: 'Green Peppers', wanted: false }
  # ]
  return
