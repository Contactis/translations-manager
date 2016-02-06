angular.module('translation.directives.searchWatchModel', [

])

.directive 'searchWatchModel', () ->
  require:'^stTable'
  scope:
    searchWatchModel:'='

  link: (scope, element, attrs, ctrl) ->
    scope.$watch 'searchWatchModel',(val) ->
      ctrl.search(val)
    return
