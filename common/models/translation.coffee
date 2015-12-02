loopback = require 'loopback'

module.exports = (Translation) ->

  Translation.export = (projectId, projectLanguageId, cb) ->

    TranslationKey = loopback.getModel('TranslationKey')

    TranslationKey.find
      where:
        projectId: projectId
    , (error, success) ->
      cb null, success


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
