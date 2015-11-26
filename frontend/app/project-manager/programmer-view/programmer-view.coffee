# # Programmer view

# @module       translation.pages.programmer-view
angular.module('translation.pages.programmer-view', [
  'ui.router'
  'ngCookies'
  'data-table'
  'toastr'
  'ngMessages'
  'ngAnimate'
  'ui.bootstrap'
  'lbServices'
  'translation.providers.userPermissionsSettings'
  'translation.directives.trWaitingSpinnerSpan'
])

.config ($stateProvider, UserPermissionsSettingsProvider) ->

  access = UserPermissionsSettingsProvider.accessLevels

  $stateProvider.state 'app.manager.programmer-view',
    url:            '/programmer-view'
    controller:     'ProgrammerViewController'
    controllerAs:   'vm'
    templateUrl:    'project-manager/programmer-view/programmer-view.tpl.html'
    data:
      access:       access.user
    resolve:
      TranslationKeysResolver: (TranslationKey) ->
        TranslationKey.find
          filter:
            include: [
              "translations": [
                "language"
                "modifiedBy"
              ]
              "project"
              "namespace"
            ]
        .$promise

.controller 'ProgrammerViewController', ($log, $http, $filter, $timeout, toastr, $cookies, $uibModal,
TranslationKeysResolver, TranslationKey, Namespace) ->
  vm = this

  vm.pending                    = true
  vm.query                      = ""
  vm.filters                    = {}
  vm.contextMenu                = {}
  vm.tableData                  = TranslationKeysResolver
  vm.defaultLanguageNativeName  = "English (English)"


  $timeout () ->
    vm.contextMenu.name   = "Programmer"
    vm.contextMenu.links  = [
      {
        name: "Export selected to..."
        method: "exportSelectedTo()"
      }
    ]
    return

  vm.addNewKey = ->
    $uibModal.open
      animation:    true
      templateUrl:  'templates/dialog/addTranslationKey.tpl.html'
      controller:   'AddTranslationKeyController'
      controllerAs: 'vm'
      size:         'lg'
      windowClass:  'center-modal'



  vm.editRow = (translationId) ->
    toastr.info $filter('translate')('APP.FRONTEND_MESSAGES.THIS_FEATURE_IS_NOT_YET_READY')
    $log.info "opened", translationId

  return vm



