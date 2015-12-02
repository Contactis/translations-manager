loopback        = require 'loopback'
Q               = require 'q'
_               = require 'lodash'

module.exports = (Translation) ->

  Translation.export = (projectId, projectLanguageId, cb) ->
    TranslationKey= loopback.getModel('TranslationKey')

    _defineProp = (obj, key, value) ->
      config =
        value: value
        writable: true
        enumerable: true
        configurable: true
      Object.defineProperty obj, key, config
      return


    _getTranslationKeyAsync = (translation, array) ->
      _deferred = Q.defer()
      TranslationKey.findOne
        where:
          id: translation.translationsKeyId
      , (err, result) ->
        if err
          _deferred.reject err
        else
          tmp = {}
          _.merge tmp, translation['__data']  # native loopback __data object
          tmp['translationKey'] = result
          _deferred.resolve tmp
      return _deferred.promise


    _getTranslations = () ->
      _deferred = Q.defer()

      Translation.find {
        where:
          languageId: projectLanguageId
      }, (err, result) ->
        if err
          _deferred.reject err
        else
          _deferred.resolve result
      return _deferred.promise


    _getTranslations().then (translationsResponse) ->
      translationKeysQuery = []
      for x in translationsResponse
        translationKeysQuery.push _getTranslationKeyAsync(x)

      Q.all(translationKeysQuery).then (translationKeysQueryResponse) ->
        return translationKeysQueryResponse
        # TODO get plurals name -> match plurals for translations -> generate and save to file form template
      , (err) ->
        console.log err
        throw error



  Translation.remoteMethod 'export',
    http:
      path: '/export'
      verb: 'get'
    accepts: [
      {
        arg:          'projectId'
        description:  'Project ID'
        type:         'string'
      }
      {
        arg:          'projectLanguageId'
        description:  'One of languages assigned to requested project'
        type:         'string'
      }
    ]
    returns:
      arg: 'list'
      type: 'string'
  return
