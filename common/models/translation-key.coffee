module.exports = (TranslationKey) ->


  _mockedMethod = () ->
    _deferred = Q.defer()

    ds = Translation.dataSource
    sql = "SELECT Translation.*
             FROM Translation
             JOIN TranslationKey
             ON TranslationKey.id = Translation.translationsKeyId
             WHERE Translation.languageId = ? AND TranslationKey.projectId = ?
             "

    ds.connector.query sql, [ projectLanguageId, projectId ], (err, result) ->
      if err
        _deferred.reject err
      else
        _deferred.resolve result
    return _deferred.promise
