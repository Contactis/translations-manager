# Languages Module
# =================
angular.module('translation.modules.languages', [
  'pascalprecht.translate'
  'tmh.dynamicLocale'
  'ngCookies'
  'angularMoment'
  'lodash'
])

# LanguageService
# ---------------
.factory 'LanguagesService', ($q, $log, $http, $rootScope, $translate, $locale, $cookieStore,
tmhDynamicLocale) ->

  # Array with supported languages by project
  _interfaceLanguages = [
    { nativeName: "English (U.S.)", ietfCode: "en-us" }
    { nativeName: "Polski (Polska)", ietfCode: "pl-pl" }
  ]


  # @method         _unifyToIetfCode
  # @param          {String}  langCode    some string with language key; like `pl-PL`
  # @description    Unify languages code notation from different browser to one
  #                 like "xx-yy" or "xx" (ex: "en-us", "en"); For
  # @returns        { String }
  _unifyToIetfCode = (inputCode) ->
    _code = inputCode.replace("_", "-")
    return _code.toLowerCase()


  # @method       _getInterfaceLanguages
  # @getter
  # @description  Get all frontend available interface languages from
  #               the database
  # @returns      {Array}
  _getInterfaceLanguages = () ->
    return _interfaceLanguages


  # @method       _getStartupLanguage
  # @setter
  # @param        {String}    [userInterfaceLanguage]   string with a language code; ex: en, en-us, pl-pl
  # @description  Determinate user startup language
  # @returns      { String }
  _getStartupLanguage = (userInterfaceLanguage) ->
    userInterfaceLanguage = \
      if typeof userInterfaceLanguage is 'undefined' or not userInterfaceLanguage
        null
      else userInterfaceLanguage

    result = switch
      when userInterfaceLanguage isnt null and not userInterfaceLanguage
        userInterfaceLanguage
      when angular.isDefined $cookieStore.get 'selectedLanguage'
        $cookieStore.get 'selectedLanguage'
      else
        if _.findWhere(_interfaceLanguages, {ietfCode: _unifyToIetfCode($translate.use())}, 'ietfCode')
          _unifyToIetfCode($translate.use())
        else
          _str = "Your language `" + _unifyToIetfCode($translate.use()) + \
            "` was not found, so used default language `en`, international english."
          $log.info _str
          'en' # en = international english, not other dialects
    return result


  # @method       _setLanguage
  # @setter
  # @param        {String}   langCode    some string with language key; like `pl-PL`
  # @description  Set user language for the website.
  _setLanguage = (ietfCode) ->
    _code = _unifyToIetfCode(ietfCode)
    $cookieStore.put('selectedLanguage', _code)
    moment.locale(_code)
    $http.defaults.headers.common['X-LANG'] = _code
    $rootScope.$locale = $locale
    $translate.use _code        # for translations strings
    tmhDynamicLocale.set _code  # set locale for translations
    # TODO Add moment.js locale file
    return


  # ### Public API
  api =
    # Change string translations and $locale
    getInterfaceLanguages:  _getInterfaceLanguages
    getStartupLanguage:     _getStartupLanguage
    setLanguage:            _setLanguage
    unifyToIetfCode:        _unifyToIetfCode
  return api


# LanguageObjectFilter
# --------------------
.filter 'languageObjectFilter', (LanguagesService) ->
  return (input) ->
    _langCode = LanguagesService.langCode()
    if angular.isDefined(input) and angular.isDefined(input[_langCode])
      return input[_langCode]

    return 'No translation key-string provided'

