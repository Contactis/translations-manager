angular.module('translation.services.account', [
  'restangular'
  'lbServices'
  'ngCookies'
  'ui.router'
  'translation.providers.userPermissionsSettings'
])


.service 'AccountService', ($q, $cookies, $http, $timeout, $state, Restangular,
UserPermissionsSettings, Account) ->

  userRoles = UserPermissionsSettings.userRoles

  _notify = $q.defer()
  _deferred = null
  _defaultAccountObject =
    role:       userRoles.public

  _account = angular.copy _defaultAccountObject

  _decodeAccountResource = (accountResource) ->
    accountResource = accountResource.toJSON()
    accountResource.role = userRoles[accountResource.role]
    return accountResource

  _accountUpdated = ->
    $timeout ->
      _notify.notify _account
    return

  _loadSession = ->
    if _deferred
      return _deferred.promise
    _deferred = $q.defer()

    Account.getCurrent (response) ->
      _account = _decodeAccountResource response
      _deferred.resolve true
      _accountUpdated()
    , (error) ->
      _deferred.resolve false
    return _deferred.promise


  api =
    loadSession:          _loadSession
    hadBeenReloaded:      (cb) ->
      _notify.promise.then null, null, cb
    resetAccount:         ->
      _account = angular.copy _defaultAccountObject
      _accountUpdated()
      return

    account: ->
      return angular.copy _account

    defaultAccountObject: ->
      return angular.copy _defaultAccountObject

    getData: (key) ->
      return _account[key]

    getAllData: () ->
      return _account

    setAccount: (newAccount) ->
      _account = angular.copy newAccount
      _accountUpdated()

  return api
