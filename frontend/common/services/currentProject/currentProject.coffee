angular.module 'translation.services.current-project', [
  'lbServices'
  'ngCookies'
  'ui.router'
]

.service 'CurrentProjectService', ($q, $cookies, $state, $timeout, Project) ->

  _currentProjectResource = {}
  _notify = $q.defer()

  _projectChanged = ->
    $timeout ->
      _notify.notify _currentProjectResource
    return

  downloadCurrentProjectIfProjectSaved = (_deferred) ->
    if _deferred is undefined
      _deferred = $q.defer()

    _savedProjectId = $cookies.get('currentProjectId')

    if _savedProjectId is undefined
      _deferred.reject('No previous project available')

    else

      downloadCurrentProject(_savedProjectId, _deferred)

    return _deferred.promise

  getCurrentProject = ->
    _deferred = $q.defer()

    if _currentProjectResource is not {}
      _deferred.resolve _currentProjectResource
    else
      downloadCurrentProjectIfProjectSaved(_deferred)

    return _deferred.promise


  parseProjectResponseResource = (response, _deferred) ->

    if response.length > 0
      _currentProjectResource = response[0]
      $cookies.put('currentProjectId', _currentProjectResource['id'])
      _projectChanged()
      _deferred.resolve(_currentProjectResource)
    else
      _deferred.reject('Saved project not found')


  downloadCurrentProject = (projectId, _deferred) ->
    if _deferred is undefined
      _deferred = $q.defer()

    Project.find
      filter:
        where:
          id: projectId
    .$promise.then (response) ->
      parseProjectResponseResource response, _deferred
    , (error) ->
      _deferred.reject(error)

    return _deferred.promise



  getProjectContext = ->
    _deferred = $q.defer()

    getCurrentProject().then (response) ->
      _deferred.resolve(response)
    , (error) ->
      $state.go('app.choose-project')
      _deferred.reject(error)



    return _deferred.promise






  api =
    getCurrentProject:      getCurrentProject
    downloadCurrentProject: downloadCurrentProject
    getProjectContext:      getProjectContext
    hasBeenChanged:         (cb) ->
      _notify.promise.then null, null, cb



  return api
