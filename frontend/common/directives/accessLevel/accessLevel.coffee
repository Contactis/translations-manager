angular.module('translation.directives.accessLevel', [
  'translation.services.account'
  'translation.providers.userPermissionsSettings'
])

.directive 'trAccessLevel', (AuthorizationService, AccountService) ->
  restrict: 'A'
  scope:
    accessLevel: '=trAccessLevel'
  link: ($scope, element, attrs) ->
    prevDisp      = element.css('display')


    $scope.$watch ->
      return AccountService.getAllData()
    , ->
      updateCSS()
    , true

    updateCSS = ->
      if $scope.accessLevel
        if !AuthorizationService.authorizePageAccess $scope.accessLevel
          element.css('display', 'none')
        else
          element.css('display', prevDisp)

    updateCSS()
