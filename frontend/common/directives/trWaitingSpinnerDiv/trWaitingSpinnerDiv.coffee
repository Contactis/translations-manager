angular.module('translation.directives.trWaitingSpinnerDiv', [])

.directive 'trWaitingSpinnerDiv', ->
  restrict:       'AE'
  replace:        true
  templateUrl:    'directives/trWaitingSpinnerDiv/trWaitingSpinnerDiv.tpl.html'
  scope:
    isPending:    '='
  link: ($scope, element, attrs) ->
    $scope.isPending = if $scope.isPending or $scope.isPending.length > 0 then true else false
    return
