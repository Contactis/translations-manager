angular.module('translation.services.filtersState', [
  'lbServices'
])

.service 'FiltersStateService', ($q, $timeout, ProjectGroup) ->

  _groups = []
  _topBarDefaultFilters = {}
  _topBarDefaultFilters.translation = [
    {
      name: "All translations"
      value: 0
      default: true
    }
    {
      name: "Missing translations"
      value: 1
    }
    {
      name: "Without missing translations"
      value: 2
    }
  ]

  _topBarDefaultFilters.plurals = [
    {
      name:     "None"
      value:    null
      default:  true
    }
    {
      name:     "Only plurals"
      value:    true
    }
    {
      name:     "Not plurals"
      value:    false
    }
  ]

  _refreshGroups = () ->
    ProjectGroup.find().$promise.then (success)->
      _groups = groupHelper(success)
    , (error) ->
      console.log "Problem with loading groups"

#      group model needs additional field (isActive) for application purposes
  groupHelper = (collection) ->
    angular.forEach collection, (value, key) ->
      value.isActive = false
    return collection


  api =
    topBarDefaultFilters: _topBarDefaultFilters
    refreshGroups: _refreshGroups
    getGroups: () ->
      return angular.copy _groups
  return api
