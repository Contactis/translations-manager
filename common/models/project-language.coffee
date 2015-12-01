module.exports = (ProjectLanguage) ->

  _transformer = (element) ->
    _tmp = JSON.stringify element
    return JSON.parse _tmp

  _cutLanguages = (array) ->
    _returnArray = []
    array.forEach (entry) ->
      _returnArray.push(_transformer(entry).language)

    return _returnArray

  ProjectLanguage.getLanguages = (projectId, cb) ->

    ProjectLanguage.find {
      include:'language'
      where:
        projectId: projectId
    }, (err, success) ->
      cb(null, _cutLanguages(success))

  ProjectLanguage.remoteMethod(
    'getLanguages'
    {
      accepts:
        arg: 'projectId'
        type: 'string'
      returns:
        arg: 'result'
        type: 'string'
    }
  )
