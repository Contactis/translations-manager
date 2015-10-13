# Languages Module
# =================
angular.module('translation.modules.languages', [
  'pascalprecht.translate'
  'tmh.dynamicLocale'
  'ngCookies'
])

# LanguageService
# ---------------
.factory 'LanguagesService', ($http, $rootScope, $translate, $locale, $cookieStore, tmhDynamicLocale) ->

  _langCode = null

  # @method       _startUpLanguage
  # @description  Determinate user startup language
  _startUpLanguage = ->
    if $cookieStore.get 'selectedLanguage'
      _setLanguage $cookieStore.get 'selectedLanguage'
    else
      _setLanguage $translate.use()

  # @method       _setLanguage
  # @setter
  # @description  Set user language for the website.
  _setLanguage = (langCode) ->
    if langCode
      # unify language notation from different browser to "xx-xx", like "en-us"
      langCode = langCode.replace("_", "-")
      langCode = langCode.toLowerCase()
      _langCode = langCode

      $cookieStore.put 'selectedLanguage', _langCode
      moment.locale(_langCode)
      $http.defaults.headers.common['X-LANG'] = _langCode
      $rootScope.$locale = $locale
      $translate.use _langCode        # set translations strings
      tmhDynamicLocale.set _langCode  # set locale for translations

  # ## Public API
  api =
    # Change string translations and $locale
    setLanguage:      _setLanguage
    startUpLanguage:  _startUpLanguage
    langCode: () ->
      return _langCode

  return api


# LanguageObjectFilter
# --------------------
.filter 'languageObjectFilter', (LanguagesService) ->
  return (input) ->
    _langCode = LanguagesService.langCode()
    if angular.isDefined(input) and angular.isDefined(input[_langCode])
      return input[_langCode]

    return 'No translation key-string provided'

