angular.module('translator.directive.trTopBar', [
])

.directive 'trTopBar', () ->
  return {
  restrict: 'E'
  replace: true
  templateUrl: 'directives/trTopBar/trTopBar.tpl.html'
  scope:
    mainSetting: '&'
    translationFilter: '='
    filter: '='

  link: (scope, element, attrs) ->

    scope.static = {}
    scope.static.translation = [
      "All translations"
      "Missing translations"
      "Without missing translations"
    ]

    scope.static.plurals = [
      "None"
      "Only plurals"
      "Not plurals"
    ]

    filter.translation = scope.static.translation[0]
    filter.plural = scope.static.plurals[0]





  }


