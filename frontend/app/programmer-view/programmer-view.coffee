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

.controller 'ProgrammerViewController', ($scope, $log, $cookies, $mdSidenav, $mdUtil) ->

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
      name: "Groups",
      prop: "name",
    }, {
      name: "Context description",
      prop: "gender"
    }, {
      name: "Default translation - English(en-GB)",
      prop: "company",
    }, {
      name: "English (en-US)"
      prop: "something"
    }, {
      name: "Polski (pl-PL)"
      prop: "wuwu"
    }]
  }
  #mocked data
  $scope.data = [
    {name: "dashboard.page_title", gender: "Name should be short and essential", company: "Home", something: "Home",
    wuwu: "Strona główna"}
    {name: "dashboard.something", gender: "Name should be short and essential", company: "Login", something: "Login",
    wuwu: "Logowanie"}
    {name: "dashboard.page_title", gender: "Name should be short and essential", company: "Home", something: "Home",
    wuwu: "Strona główna"}
    {name: "dashboard.something", gender: "Name should be short and essential", company: "Login", something: "Login",
    wuwu: "Logowanie"}
    {name: "dashboard.page_title", gender: "Name should be short and essential", company: "Home", something: "Home",
    wuwu: "Strona główna"}
    {name: "dashboard.something", gender: "Name should be short and essential", company: "Login", something: "Login",
    wuwu: "Logowanie"}
    {name: "dashboard.page_title", gender: "Name should be short and essential", company: "Home", something: "Home",
    wuwu: "Strona główna"}
    {name: "dashboard.something", gender: "Name should be short and essential", company: "Login", something: "Login",
    wuwu: "Logowanie"}
    {name: "dashboard.page_title", gender: "Name should be short and essential", company: "Home", something: "Home",
    wuwu: "Strona główna"}
    {name: "dashboard.something", gender: "Name should be short and essential", company: "Login", something: "Login",
    wuwu: "Logowanie"}
  ]
  return


