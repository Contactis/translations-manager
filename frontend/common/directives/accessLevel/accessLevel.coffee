angular.module('translation.directives.accessLevel', [
  'translation.services.user'
  'translation.providers.userPermissionsSettings'
])

.directive 'trAccessLevel', (AuthorizationService, UserService) ->
  restrict: 'A'
  link: ($scope, element, attrs) ->
    prevDisp      = element.css('display')
    userRole      = null
    accessLevel   = null

    $scope.user = UserService.getAllData()
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
