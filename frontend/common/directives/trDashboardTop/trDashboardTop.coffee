angular.module('translator.directive.trDashboardTop', [
  'translation.services.filtersState'
])

.directive 'trDashboardTop', (FiltersStateService) ->
  restrict: 'E'
  replace: true
  templateUrl: 'directives/trDashboardTop/trDashboardTop.tpl.html'

  link: (scope, element, attrs) ->

    return
