angular.module('translation.pages.dashboard', [
  'ui.router'
  'data-table'
  'translation.services.projects'
  'translation.providers.userPermissionsSettings'
])

.config ($stateProvider, UserPermissionsSettingsProvider) ->

  access = UserPermissionsSettingsProvider.accessLevels

  $stateProvider.state 'app.dashboard',
    url:            '/dashboard'
    controller:     'DashboardController'
    templateUrl:    'dashboard/dashboard.tpl.html'
    data:
      access: access.user


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
  $scope.test = [
    'no elo'
    'lalala'
  ]
  $scope.filter.translation = $scope.static.translation[0]
  $scope.filter.plural = $scope.static.plurals[0]




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
