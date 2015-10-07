angular.module 'translation.services.filtersState', []

.service 'filtersStateService', ($q, $timeout, Restangular) ->

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


  api =
    topBarDefaultFilters : _topBarDefaultFilters
  return api
