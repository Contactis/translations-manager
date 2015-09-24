angular.module('translation.dashboard', [
  'ui.router'
])

.config ($stateProvider) ->

  $stateProvider.state 'app.dashboard',
    url:            '/dashboard'
    controller:     'DashboardController'
    templateUrl:    'dashboard/dashboard.tpl.html'

.controller 'DashboardController', ($scope) ->
  $scope.filter = {}
  $scope.static = {}
  $scope.languageList = ['pl','en','de']

  $scope.static.translation = [
    "All translations"
    "Missing translations"
    "Without missing translations"
  ]

  $scope.static.plurals = [
    "None"
    "Only plurals"
    "Not plurals"
  ]

  $scope.filter.translation = $scope.static.translation[0]
  $scope.filter.plural = $scope.static.plurals[0]

  return


