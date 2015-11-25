# Lodash Module
# =============
angular.module('lodash', [])

# Lodash Service
# --------------
.factory '_', ($window) ->
  return $window._
