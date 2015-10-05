angular.module('translator.directive.trTopBar', [
  'translation.services.filtersState'
])

.directive 'trTopBar', (filtersStateService) ->
  return {
  restrict: 'E'
  replace: true
  templateUrl: 'directives/trTopBar/trTopBar.tpl.html'
  scope:
    mainSetting: '&'
    translationFilter: '='
    filter: '=filter'

  link: (scope, element, attrs) ->

    scope.static = filtersStateService.topBarDefaultFilters

    scope.filter.translation = scope.static.translation[0]
    scope.filter.plural = scope.static.plurals[0]

  }


