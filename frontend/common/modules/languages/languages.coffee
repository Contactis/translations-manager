# Languages Module
# =================
angular.module('translation.modules.languages', [
  'pascalprecht.translate'
  'tmh.dynamicLocale'
  'ngCookies'
  'angularMoment'
])

# LanguageService
# ---------------
.factory 'LanguagesService', ($http, $rootScope, $translate, $locale, $cookieStore, tmhDynamicLocale) ->

  _langCode = null

  # @method         _unifyIetfCode
  # @param          langCode
  # @description    unify language notation from different browser to "xx-xx",
  #                 like "en-us"
  _unifyIetfCode = (langCode) ->
    _langCode = langCode.replace("_", "-")
    return _langCode.toLowerCase()


  # @method       _getStartupLanguage
  # @setter
  # @param        [userInterfaceLanguage]
  # @description  Determinate user startup language
  _getStartupLanguage = (userInterfaceLanguage) ->
    userInterfaceLanguage = if typeof userInterfaceLanguage is 'undefined' then null else userInterfaceLanguage
    userLang = undefined
    switch
      when angular.isDefined $cookieStore.get 'selectedLanguage'
        console.log "cookie is defined", $cookieStore.get 'selectedLanguage'
        userLang = $cookieStore.get 'selectedLanguage'
      when userInterfaceLanguage isnt null
        console.log "userInterfaceLanguage", userInterfaceLanguage
        userLang = userInterfaceLanguage
      else
        console.log "$translate.use()", $translate.use()
        userLang = $translate.use()
    return userLang

  # @method       _setLanguage
  # @setter
  # @param        langCode
  # @description  Set user language for the website.
  _setLanguage = (langCode) ->
    _langCode = _unifyIetfCode(langCode)
    $cookieStore.put('selectedLanguage', _langCode)
    moment.locale(_langCode)
    $http.defaults.headers.common['X-LANG'] = _langCode
    $rootScope.$locale = $locale
    $translate.use _langCode        # for translations strings
    tmhDynamicLocale.set _langCode  # set locale for translations
    # TODO Add moment.js locale file
    return

  # ## Public API
  api =
    # Change string translations and $locale
    setLanguage:          _setLanguage
    getStartupLanguage:   _getStartupLanguage
    langCode:             () ->
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

