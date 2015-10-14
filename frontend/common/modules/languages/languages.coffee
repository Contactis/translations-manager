# Languages Module
# =================
angular.module('translation.modules.languages', [
  'pascalprecht.translate'
  'tmh.dynamicLocale'
  'ngCookies'
  'angularMoment'
  'angular-lodash'
])

# LanguageService
# ---------------
.factory 'LanguagesService', ($q, $log, $http, $rootScope, $translate, $locale, $cookieStore, tmhDynamicLocale,
Restangular) ->

  _langCode = null
  _deferredInterfaceLanguages = undefined


  # @method         _unifyToIetfCode
  # @param          langCode
  # @description    unify languages code notation from different browser to one
  #                 like "xx-yy" or "xx" (ex: "en-us", "en")
  # @returns        String
  _unifyToIetfCode = (inputCode) ->
    _code = inputCode.replace("_", "-")
    return _code.toLowerCase()


  # @method       _getInterfaceLanguages
  # @getter
  # @description  Get all frontend available interface languages from
  #               the database
  # @returns      Promise
  _getInterfaceLanguages = () ->
    if _deferredInterfaceLanguages
      return _deferredInterfaceLanguages.promise
    _deferredInterfaceLanguages = $q.defer()

    Restangular.one('Languages').getList().then (response) ->
      _deferredInterfaceLanguages.resolve(response.plain())
    , (error) ->
      console.log "Languages error: ", error
      _deferredInterfaceLanguages.reject()
    return _deferredInterfaceLanguages.promise


  # @method       _getStartupLanguage
  # @setter
  # @param        [userInterfaceLanguage]
  # @description  Determinate user startup language
  # @returns      Promise
  _getStartupLanguage = (userInterfaceLanguage) ->
    _deferred = $q.defer()

    userInterfaceLanguage = \
      if typeof userInterfaceLanguage is 'undefined' or not userInterfaceLanguage
        null
      else userInterfaceLanguage

    switch
      when userInterfaceLanguage isnt null and not userInterfaceLanguage
        console.log "userInterfaceLanguage", userInterfaceLanguage
        _deferred.resolve userInterfaceLanguage
      when angular.isDefined $cookieStore.get 'selectedLanguage'
        console.log "cookie is defined", $cookieStore.get 'selectedLanguage'

        _deferred.resolve $cookieStore.get 'selectedLanguage'
      else
        console.log "$translate.use()", _unifyToIetfCode($translate.use())
        _getInterfaceLanguages().then (success) ->
          console.log "success", success
          _interfaceLangs = success
          if _.findWhere(_interfaceLangs, {ietfCode: _unifyToIetfCode($translate.use())}, 'ietfCode')
            _deferred.resolve _unifyToIetfCode($translate.use())
          else
            _str = "Your language `" + _unifyToIetfCode($translate.use()) + \
              "` was not found, so used default language `en`, international english."
            $log.info _str
            _deferred.resolve 'en' # en = international english, not en-us or others
        , (e) ->
          console.log "error", e
          _deferred.reject()
    return _deferred.promise


  # @method       _setLanguage
  # @setter
  # @param        langCode
  # @description  Set user language for the website.
  _setLanguage = (ietfCode) ->
    console.log "_setLanguage ietfCode", ietfCode
    _code = _unifyToIetfCode(ietfCode)
    $cookieStore.put('selectedLanguage', _code)
    moment.locale(_code)
    $http.defaults.headers.common['X-LANG'] = _code
    $rootScope.$locale = $locale
    $translate.use _code        # for translations strings
    tmhDynamicLocale.set _code  # set locale for translations
    # TODO Add moment.js locale file
    return


  # ## Public API
  api =
    # Change string translations and $locale
    langCode:               () ->
      return _langCode
    getInterfaceLanguages:  _getInterfaceLanguages
    getStartupLanguage:     _getStartupLanguage
    setLanguage:            _setLanguage
  return api


# LanguageObjectFilter
# --------------------
.filter 'languageObjectFilter', (LanguagesService) ->
  return (input) ->
    _langCode = LanguagesService.langCode()
    if angular.isDefined(input) and angular.isDefined(input[_langCode])
      return input[_langCode]

    return 'No translation key-string provided'

