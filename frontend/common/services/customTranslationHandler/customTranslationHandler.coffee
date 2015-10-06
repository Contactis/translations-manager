# Custom Translation Handler Service
# ==================================
# This module provide single service for reporting missing translations
angular.module('translation.services.customTranslationHandler', [
  'pascalprecht.translate'
  'angular-lodash'
])

# Custom Translation Handler Service
# ----------------------------------
.factory 'CustomTranslationHandlerService', ($translate, $log) ->

  # List of strings that shouldn't be reported to log
  _exceptionsStrings = [
    'Do not report this dummy translate string, for ex like icon below'
    '<i class="icon icon-home icon-sm"></i>'
  ]

  return (translationId, uses) ->
    if translationId isnt undefined and not _.include(_exceptionsStrings, translationId)
      _str = "Missing [" + uses + "] translations for: " + translationId
      $log.error(_str)

