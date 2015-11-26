angular.module('translation.directives.trWaitingSpinnerSpan', [])

.directive 'trWaitingSpinnerSpan', ->
  restrict:       'AE'
  replace:        true
  templateUrl:    'directives/trWaitingSpinnerSpan/trWaitingSpinnerSpan.tpl.html'
  scope:
    isPending:    '='
  link: ($scope, element, attrs) ->
    $scope.isPending = if $scope.isPending or $scope.isPending.length > 0 then true else false
    return
