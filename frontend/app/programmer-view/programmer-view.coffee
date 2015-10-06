angular.module('translation.pages.programmer-view', [
  'ui.router'
  'ngCookies'
  'ngMaterial'
  'translation.providers.userPermissionsSettings'
  'data-table'
])

.config ($stateProvider, UserPermissionsSettingsProvider) ->

  access = UserPermissionsSettingsProvider.accessLevels

  $stateProvider.state 'app.programmer-view',
    url:            '/programmer-view'
    controller:     'ProgrammerViewController'
    templateUrl:    'programmer-view/programmer-view.tpl.html'
    data:
      access: access.user

.controller 'ProgrammerViewController', ($scope, $log, $cookies, $mdSidenav, $mdUtil, $mdDialog) ->


  $scope.filter = {}

  # buildToggler = (navID) ->
  #   debounceFn = $mdUtil.debounce( () ->
  #     $mdSidenav(navID)
  #       .toggle()
  #       .then () ->
  #         $log.debug("toggle " + navID + " is done")

  #   , 200)
  #   return debounceFn

  # $scope.toogleLeft = () ->
  #   $mdSidenav()

  $scope.toogleSidenav = (componentId) ->
    $mdSidenav(componentId)
      .toggle()
      .then( () ->
        $log.debug('toggled')
      )


  $scope.toggleSidenav = () ->
    $mdSidenav(menu).close().then () ->
      $log.debug("close LEFT is done")


  $scope.options = {
    rowHeight: 50,
    footerHeight: false,
    headerHeight: 40,
    scrollbarV: false,

    columnMode: 'force',
    columns: [{
      name: "Key",
      prop: "key",
    }, {
      name: "Basic translations:",
      prop: "translation"
    }, {
      name: "Context description",
      prop: "description",
    }]
  }
  #mocked data
  $scope.data = [
    {key: "dashboard.page_title.home", translation: "Home", description: "Name should be short and essential"},
    {key: "dashboard.page_title.login", translation: "Login", description: "Name should be short and essential"}
  ]




  $scope.showAdvanced = (ev) ->
    $mdDialog.show
      controller: DialogController
      templateUrl: "templates/dialog/translation.tpl.html"
      parent: angular.element(document.body)
      targetEvent: ev
      clickOutsideToClose: true

  DialogController = ($scope, $mdDialog) ->
    $scope.currentKey = {}
    $scope.currentKey.isPlural = true
    $scope.closeDialog = () ->
      $mdDialog.hide()

    $scope.saveKey = () ->
      console.log 'saving key!'

    $scope.languagePlurals = [
      { plural: "One"}
      { plural: "Other"}

    ]

  DialogController.$inject = ["$scope", "$mdDialog"]


  return


