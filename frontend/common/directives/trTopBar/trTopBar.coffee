angular.module('translator.directive.trTopBar', [
  'translation.services.filtersState'
])

.directive 'trTopBar', (filtersStateService) ->
  restrict: 'E'
  replace: true
  templateUrl: 'directives/trTopBar/trTopBar.tpl.html'
  scope:
    mainSetting:        '&'
    query:              '='
    contextMenu:        '='
    filters:            '='

  link: (scope, element, attrs) ->
    scope.static = filtersStateService.topBarDefaultFilters

    scope.contextMenu.name    = "<menu name not set>"
    scope.contextMenu.links   = []

    scope.filters.translation = scope.static.translation[0]
    scope.filters.plural      = scope.static.plurals[0]
    scope.filters.inputSearch = ''

    console.log "scope.contextMenu", scope.contextMenu
    console.log "scope.filters", scope.filters

    return
