angular.module('translation.directive.searchWatchModel', [

])

.directive 'searchWatchModel', () ->
  require:'^stTable'
  scope:
    searchWatchModel:'='

  link: (scope, element, attrs, ctrl) ->
    console.log "WOOGOHO IT'S WORKING"
    scope.$watch 'searchWatchModel',(val) ->
      ctrl.search(val)
    return
