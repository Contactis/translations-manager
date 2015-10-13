angular.module('translation.services.account', [
  'restangular'
  'lbServices'
  'ngCookies'
  'ngMaterial'
  'ui.router'
  'translation.providers.userPermissionsSettings'
])


.service 'AccountService', ($q, $cookies, $http, $timeout, $state, $mdToast, Restangular,
UserPermissionsSettings, Account) ->

  accessLevels  = UserPermissionsSettings.accessLevels
  userRoles     = UserPermissionsSettings.userRoles

  _notify = $q.defer()

  _deferred = null

  _defaultAccountObject =
    role:       userRoles.public

  _account = angular.copy _defaultAccountObject

  _accountUpdated = ->
    $timeout ->
      _notify.notify _account

  loadSession = ->

    if _deferred
      return _deferred.promise

    _deferred = $q.defer()

    Account.getCurrent (response) ->
      _account = response.toJSON()

      _deferred.resolve true
      _accountUpdated()

    , (error) ->
      _deferred.resolve false


    return _deferred.promise

  api =
    loadSession:           loadSession
    updated:              _notify.promise

    resetAccount: ->
      _account = angular.copy _defaultAccountObject

      _accountUpdated()

      return

    account: ->
      return angular.copy _account

    defaultAccountObject: ->
      return angular.copy _defaultAccountObject

    getData: (key) ->
      return _account[key]

    setAccount: (newAccount) ->
      _account = angular.copy newAccount
      _accountUpdated()




  return api
