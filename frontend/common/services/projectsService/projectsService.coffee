angular.module 'projectsService', [
  'restangular'
]
.service 'projects', ($q, $timeout, Restangular) ->

  _notify = $q.defer()
  _projectQueue = null

  getProject = (projectId) ->

    if _projectQueue
      return _projectQueue.promise

    _projectQueue = $q.defer()

    Restangular.one('projects', projectId).get().then (project) ->
      project = project.plain()

      $timeout ->
        _notify.notify project

      _projectQueue.resolve project
    , (err) ->
      _projectQueue.reject err

    return _projectQueue.promise


  api =
    get:      getProject
    updated:  _notify.promise


  return api
