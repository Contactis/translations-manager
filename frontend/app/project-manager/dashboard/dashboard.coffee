angular.module('translation.pages.dashboard', [
  'ui.router'
  'data-table'
  'translation.providers.userPermissionsSettings'
  'translation.directives.trDashboardTop'
])

.config ($stateProvider, UserPermissionsSettingsProvider) ->

  access = UserPermissionsSettingsProvider.accessLevels

  $stateProvider.state 'app.manager.dashboard',
    url:            '/dashboard'
    controller:     'DashboardController'
    controllerAs:   'vm'
    templateUrl:    'project-manager/dashboard/dashboard.tpl.html'
    data:
      access:       access.user


.controller 'DashboardController', ($filter, toastr) ->
  vm = this


  vm.notImplemented = ->
    toastr.info $filter('translate')('APP.FRONTEND_MESSAGES.THIS_FEATURE_IS_NOT_YET_READY')

  return
