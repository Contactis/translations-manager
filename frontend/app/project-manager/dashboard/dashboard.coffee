angular.module('translation.pages.dashboard', [
  'ui.router'
  'data-table'
  'translation.providers.userPermissionsSettings'
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


.controller 'DashboardController', () ->
  vm = this

  vm.filter = {}
  vm.static = {}
  vm.languageList = ['pl','en','de']

  vm.static.translation = [
    "All translations"
    "Missing translations"
    "Without missing translations"
  ]

  vm.static.plurals = [
    "None"
    "Only plurals"
    "Not plurals"
  ]
  vm.test = [
    'no elo'
    'lalala'
  ]
  vm.filter.translation = vm.static.translation[0]
  vm.filter.plural = vm.static.plurals[0]




  vm.options = {
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
  vm.data = [
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
