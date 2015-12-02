loopback        = require 'loopback'
Q               = require 'q'

module.exports = (Translation) ->

  Translation.export = (projectId, projectLanguageId, cb) ->
    TranslationKey= loopback.getModel('TranslationKey')

    getTranslations = () ->
      _deferred = Q.defer()

      Translation.find {
        include: [
          {relation: 'language'}
          {relation: 'translationKey'}
          {
            relation: 'status'
            scope:
              fields: [ 'id', 'keyString' ]
          }
        ]
        where:
          languageId: projectLanguageId
      }, (err, result) ->
        if err
          _deferred.reject err
        else
          _deferred.resolve result
      return _deferred.promise

    getTranslations().then (translationsResponse) ->
      defineProp = (obj, key, value) ->
        config =
          value: value
          writable: true
          enumerable: true
          configurable: true
        Object.defineProperty obj, key, config
        return

      _finalResult = {}
      _count = 0

      for x in translationsResponse
        if x.translationKey
          defineProp(_finalResult, x.id, x.translatedPhrase)
        _count += 1
      return translationsResponse
      #return _finalResult
      #return _count


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
