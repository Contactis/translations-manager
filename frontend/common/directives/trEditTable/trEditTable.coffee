angular.module('translator.directive.trEditTable', [
])

.directive 'trDashboardTop', () ->
  restrict: 'E'
  replace: true
  templateUrl: 'directives/trEditTable/trEditTable.tpl.html'
  scope:
    varValue:'='
  link: (scope, element, attrs) ->

    return
