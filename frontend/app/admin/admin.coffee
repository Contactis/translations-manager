angular.module('translation.pages.admin', [

])
.config ($stateProvider, UserPermissionsSettingsProvider) ->

  access = UserPermissionsSettingsProvider.accessLevels

  $stateProvider.state 'app.admin',
    abstract:       true
    url:            '/admin'
    controller:     'AdminController'
    templateUrl:    'admin/admin.tpl.html'
    data:
      access: access.management

.controller 'AdminController', ->
