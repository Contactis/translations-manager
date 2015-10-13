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
  'lbServices'
])


.controller 'SidenavController', ($scope, $rootScope, $state, $cookies, Account, filtersStateService,
$mdSidenav, $mdUtil, ProjectsService, AccountService, AuthorizationService) ->

  $scope.user = AccountService.account()
  $scope.user.loggedIn = Account.isAuthenticated()


  $scope.goTo = (uiview) ->
    $state.go(uiview)

  $scope.countLanguages = 8
  $scope.countKeys = 1234

  $scope.currentProject = {}

  ProjectsService.updated.then null, null, (project) ->
    $scope.currentProject = project

  AccountService.updated.then null, null, (user) ->
    $scope.user = user
    $scope.user.loggedIn = Account.isAuthenticated()



  $scope.pages = [
    { name: "Programmer view", sref: "app.programmer-view" }
    { name: "Manager view", sref: "app.manager-view" }
    { name: "Translator view", sref: "app.translator-view" }
    { name: "Admin view", sref: "app.admin-view" }
  ]

  $rootScope.logout = AuthorizationService.logout

  $scope.groups = filtersStateService.getGroups()



  $rootScope.changeProject = () ->
    console.log "change project"



  # $scope.pages = [
  #   { name: 'Pepperoni', wanted: true }
  #   { name: 'Sausage', wanted: false }
  #   { name: 'Black Olives', wanted: true }
  #   { name: 'Green Peppers', wanted: false }
  # ]
  return
