angular.module('translation.controllers.sidenav', [
  'ui.router'
  'ngAnimate'
  'ngAria'
  'ngMaterial'
])

.controller 'SidenavController', ($scope, $state, $mdSidenav, $mdUtil) ->

  $scope.goTo = (uiview) ->
    $state.go(uiview)

  $scope.countLanguages = 8
  $scope.countKeys = 1234

  $scope.pages = [
    { name: "Dashboard", sref: "app.dashboard" }
    { name: "Login", sref: "app.login" }
    { name: "Programmer view", sref: "app.programmer-view" }
    { name: "Manager view", sref: "app.manager-view" }
    { name: "Translator view", sref: "app.translator-view" }
    { name: "Admin view", sref: "app.admin-view" }
  ]



  # $scope.pages = [
  #   { name: 'Pepperoni', wanted: true }
  #   { name: 'Sausage', wanted: false }
  #   { name: 'Black Olives', wanted: true }
  #   { name: 'Green Peppers', wanted: false }
  # ]
  return
