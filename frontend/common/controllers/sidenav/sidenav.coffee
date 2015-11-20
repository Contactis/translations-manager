angular.module('translation.controllers.sidenav', [
  'ui.router'
  'ngAnimate'
  'ngCookies'
  'ngAria'
  'translation.services.account'
  'translation.services.authorization'
  'translation.services.filtersState'
  'translation.services.current-project'
  'lbServices'
])


.controller 'SidenavController', ($rootScope, $state, $cookies, Account, FiltersStateService,
AccountService, AuthorizationService, CurrentProjectService) ->

  vm = this

  vm.account = AccountService.account()
  vm.account.loggedIn = Account.isAuthenticated()


  vm.goTo = (uiview) ->
    $state.go(uiview)

  vm.countLanguages = 8
  vm.countKeys = 1234

  vm.currentProject = {}

  CurrentProjectService.hadBeenChanged (project) ->
    vm.currentProject = project


  AccountService.hadBeenReloaded (account) ->
    vm.account = account
    vm.account.loggedIn = Account.isAuthenticated()



  vm.pages = [
    { name: "Programmer view", sref: "app.programmer-view" }
    { name: "Manager view", sref: "app.manager-view" }
    { name: "Translator view", sref: "app.translator-view" }
    { name: "Admin view", sref: "app.admin-view" }
  ]

  $rootScope.logout = AuthorizationService.logout

  vm.groups = FiltersStateService.getGroups()



  $rootScope.changeProject = () ->
    console.log "change project"


  return vm
