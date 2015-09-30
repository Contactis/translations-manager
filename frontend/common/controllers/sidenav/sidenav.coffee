angular.module('translation.controllers.sidenav', [
  'ui.router'
  'ngAnimate'
  'ngCookies'
  'ngAria'
  'ngMaterial'
  'projectsService'
])


.controller 'SidenavController', ($scope, $rootScope, $state, $cookies,
$mdSidenav, $mdUtil, projects) ->


  $scope.goTo = (uiview) ->
    $state.go(uiview)

  $scope.countLanguages = 8
  $scope.countKeys = 1234

  $scope.userdata =
    fullname:   "John Doe"
    email:      "johndoe@example.com"

  $scope.currentProject = {}

  projects.updated.then null, null, (project) ->
    $scope.currentProject = project


  $scope.pages = [
    { name: "Login", sref: "app.login" }
    { name: "Programmer view", sref: "app.programmer-view" }
    { name: "Manager view", sref: "app.manager-view" }
    { name: "Translator view", sref: "app.translator-view" }
    { name: "Admin view", sref: "app.admin-view" }
  ]

  $rootScope.logout = () ->
    $cookies.remove 'token'
    $state.go 'app.login'

  $rootScope.changeProject = () ->
    console.log "change project"



  # $scope.pages = [
  #   { name: 'Pepperoni', wanted: true }
  #   { name: 'Sausage', wanted: false }
  #   { name: 'Black Olives', wanted: true }
  #   { name: 'Green Peppers', wanted: false }
  # ]
  return
