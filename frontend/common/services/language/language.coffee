angular.module('translation.services.language', [
  'lbServices'
  'ngCookies'
])

.service 'LanguageService', ($q, $cookies, ProjectLanguage, Language) ->


  _setTranslationLanguageId = (id) ->
    $cookies.put('translateLanguageId', id)

  _getTranslationLanguageId = () ->
    _id = $cookies.get('translateLanguageId')
    if _id is undefined
      return undefined
    else
      return parseInt(_id)

  _getTranslationLanguageIdOrFind = (_defaultLanguageId, _languageList) ->
    _id = _getTranslationLanguageId()
    if _id is undefined
      _element = _.find _languageList, (element) ->
        return element.id!=_defaultLanguageId
      return _element.id
    else
      return _id


  _getAllTranslationsForProject = (projectId) ->
    ProjectLanguage.getLanguages({projectId:projectId}).$promise.then (success) ->
      return success

  _getTranslateLanguage = (languageList, defaultLanguageId) ->
    _id = _getTranslationLanguageId()
    if _id is undefined
      for element, index in languageList
        if element.id!=defaultLanguageId
          return languageList[index]
    else
      _index = _.find languageList, (element) ->
        return element.id==_id

    return _index

  api =
    setTranslationLanguageId        : _setTranslationLanguageId
    getTranslationLanguageId        : _getTranslationLanguageId
    getTranslationLanguageIdOrFind  : _getTranslationLanguageIdOrFind
    getAllTranslationsForProject    : _getAllTranslationsForProject
    getTranslateLanguage            : _getTranslateLanguage


  return api
