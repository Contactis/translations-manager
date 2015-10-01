angular.module('translation.controllers.sidenav', [
  'ui.router'
  'ngAnimate'
  'ngCookies'
  'ngAria'
  'ngMaterial'
  'translation.services.projects'
  'translation.services.user'
])


.controller 'SidenavController', ($scope, $rootScope, $state, $cookies,
$mdSidenav, $mdUtil, ProjectsService, UserService) ->

  $scope.goTo = (uiview) ->
    $state.go(uiview)

  $scope.countLanguages = 8
  $scope.countKeys = 1234

  $scope.userdata =
    fullname: 24324
    email: 2345235

  $scope.currentProject = {}

  ProjectsService.updated.then null, null, (project) ->
    $scope.currentProject = project


  $scope.pages = [
    { name: "Login", sref: "app.login" }
    { name: "Programmer view", sref: "app.programmer-view" }
    { name: "Manager view", sref: "app.manager-view" }
    { name: "Translator view", sref: "app.translator-view" }
    { name: "Admin view", sref: "app.admin-view" }
  ]

  $rootScope.logout = UserService.logout

  $scope.groups = [
    { name: "All", isActive: true }
    { name: "dashboard", isActive: false }
    { name: "media.side.awesome", isActive: true }
    { name: "title.pages", isActive: false }
  ]



  $rootScope.changeProject = () ->
    console.log "change project"



  # $scope.pages = [
  #   { name: 'Pepperoni', wanted: true }
  #   { name: 'Sausage', wanted: false }
  #   { name: 'Black Olives', wanted: true }
  #   { name: 'Green Peppers', wanted: false }
  # ]
  return
