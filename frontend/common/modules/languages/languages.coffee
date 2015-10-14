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


  # @method         _unifyIetfCode
  # @param          langCode
  # @description    unify language notation from different browser to "xx-xx",
  #                 like "en-us"
  _unifyIetfCode = (langCode) ->
    _langCode = langCode.replace("_", "-")
    return _langCode.toLowerCase()

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
  _getStartupLanguage = (userInterfaceLanguage) ->
    userInterfaceLanguage = \
      if typeof userInterfaceLanguage is 'undefined' or not userInterfaceLanguage
        null
      else userInterfaceLanguage

    userLang = undefined
    switch
      when angular.isDefined $cookieStore.get 'selectedLanguage'
        console.log "cookie is defined", $cookieStore.get 'selectedLanguage'
        userLang = $cookieStore.get 'selectedLanguage'
      when userInterfaceLanguage isnt null
        console.log "userInterfaceLanguage", userInterfaceLanguage
        userLang = userInterfaceLanguage
      else
        console.log "$translate.use()", _unifyIetfCode($translate.use())
        _getInterfaceLanguages().then (success) ->
          _interfaceLangs = success
          if _.findWhere(_interfaceLangs, {ietfCode: _unifyIetfCode($translate.use())}, 'ietfCode')
            userLang = _unifyIetfCode($translate.use())
          else
            $log.info "Your language `" + $translate.use() + "` was not found so we use default language `en-us`"
            userLang = 'en-us'
        , (e) ->
          console.log "error", e
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
    getInterfaceLanguages:  _getInterfaceLanguages
    setLanguage:            _setLanguage
    getStartupLanguage:     _getStartupLanguage
    langCode:               () ->
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

