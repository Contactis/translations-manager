angular.module('translation.directives.accessLevel', [
  'translation.services.account'
  'translation.providers.userPermissionsSettings'
])

.directive 'trAccessLevel', (AuthorizationService, AccountService) ->
  restrict: 'A'
  link: ($scope, element, attrs) ->
    prevDisp      = element.css('display')
    userRole      = null
    accessLevel   = null

    $scope.user = AccountService.getAllData()
    $scope.$watch 'user', (user) ->
      if user.role
        userRole = user.role
      updateCSS()
    , true

    attrs.$observe 'trAccessLevel', (al) ->
      if al
        accessLevel = $scope.$eval(al)
      updateCSS()

    updateCSS = () ->
      if userRole and accessLevel
        if !AuthorizationService.authorizePageAccess(accessLevel, userRole)
          element.css('display', 'none')
        else
          element.css('display', prevDisp)
