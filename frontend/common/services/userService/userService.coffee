angular.module 'userService', ['restangular']

.service 'user', ($q, Restangular) ->

  _deferred = null

  _defaultUserObject =
    loggedIn:   false
    username:   'Unknown'
    firstName:  'First name'
    lastName:   'Last name'
    token:      'LKn9ufbgup93qiglbKJHfds9u03houqdlksf1ughbz'



  getSession = ->

    if _deferred
      return _deferred.promise

    _deferred = $q.defer()

    _deferred.resolve _defaultUserObject


    return _deferred.promise


  api =
    getSession: getSession



  return api
