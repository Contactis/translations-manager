angular.module 'translation.services.current-project', [
  'lbServices'
]

.service 'CurrentProjectService', ($q, Project) ->

  api =
    getProject: ->
      _deferred = $q.defer()


      Project.find().$promise


      _deferred.resolve()


      return _deferred


  return api
