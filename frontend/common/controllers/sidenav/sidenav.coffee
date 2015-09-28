angular.module('translation.controllers.sidenav', [
  'ngAnimate'
  'ngAria'
  'ngMaterial'
])

.controller 'SidenavController', ($scope, $mdSidenav) ->

  $scope.pages = [
    { name: 'Pepperoni', wanted: true }
    { name: 'Sausage', wanted: false }
    { name: 'Black Olives', wanted: true }
    { name: 'Green Peppers', wanted: false }
  ]
  return
