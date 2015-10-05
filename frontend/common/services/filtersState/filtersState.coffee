angular.module 'translation.services.filtersState', [

]

.service 'filtersStateService', ($q, $timeout, Restangular) ->

  _topBarDefaultFilters = {}
  _topBarDefaultFilters.translation = [
    "All translations"
    "Missing translations"
    "Without missing translations"
  ]

  _topBarDefaultFilters.plurals = [
    "None"
    "Only plurals"
    "Not plurals"
  ]




  api =
    topBarDefaultFilters : _topBarDefaultFilters


  return api
