pluralFormList  = require '../pluralForms'
loopback        = require 'loopback'
Q               = require 'q'
_               = require 'lodash'
isjs            = require 'is-js'


module.exports = (Translation) ->

  Translation.export = (projectId, projectLanguageId, cb) ->
    #  INFO
    #  In this exporter we used `angular` with modules: `angular-translate`,
    #  `angular-translate-interpolation-messageformat`

    TranslationKey  = loopback.getModel('TranslationKey')
    Namespace       = loopback.getModel('Namespace')

    _defineProp = (obj, key, value) ->
      config =
        value: value
        writable: true
        enumerable: true
        configurable: true
      Object.defineProperty obj, key, config
      return


    _getKeyByValue = (object, value) ->
      for prop of object
        if object.hasOwnProperty(prop)
          if object[prop] == value
            return prop
      return

    _getTranslationKeyAsync = (translation) ->
      _deferred = Q.defer()
      TranslationKey.findOne
        where:
          id: translation.translationsKeyId
          projectId: projectId # projectId from main method
      , (err, result) ->
        if err
          _deferred.reject err
        else
          tmp = {}
          _.merge tmp, translation['__data']  # native lodash __data object
          tmp['translationKey'] = result
          _deferred.resolve tmp
      return _deferred.promise


    _getNamespaceAsync = (namespaceId) ->
      _deferred = Q.defer()
      Namespace.findOne
        where:
          id: namespaceId
      , (err, result) ->
        if err
          _deferred.reject err
        else
          _deferred.resolve result
      return _deferred.promise


    # @returns    {Object}    it returns same translationKeyObj with additional property of `namespaces`.
    #                         for now name space ale single object in array that because it not get full path of
    #                         namespace
    _getTranslationKeyWithNamespaceAsync = (translationKeyObj) ->
      if not isjs.object translationKeyObj
        msg = 'translationKeyObj is not Object'
        console.log msg
        throw new Error msg
      _deferred = Q.defer()
      Namespace.findOne
        where:
          id: translationKeyObj.namespaceId
      , (err, result) ->
        if err
          _deferred.reject err
        else
          obj = _.merge {}, translationKeyObj['__data']
          obj['namespaces'] = []
          #_defineProp(translationKeyObj, 'namespaces', "dsdsdsd")
          #console.log 'obj', obj
          obj.namespaces.push result
          _deferred.resolve obj
      return _deferred.promise


    #_getFullNamespacePathAsync = (namespaceId, callback) ->
      #if typeof callback is 'undefined' then throw new Error("callback parameter is undefined")
      #if not isjs.function(callback) then throw new Error("callback parameter is not a function")
      #_getNamespaceAsync(namespaceId).then (namespaceResult) ->
        #if namespaceResult.parentId isnt null

      #Q.all(query)


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
        # TODO get plurals name -> match plurals for translations -> generate and save to file form template

        # separate to reduce queries
        _results =
          plurals: []
          strings: []
        for item in translationKeysQueryResponse
          if item.pluralForm is null
            _results.strings.push item
          else
            _results.plurals.push item

        _oldResults = _.merge {}, _results
        console.log "REEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEESULTS", _oldResults

        # sort for plurals that refers to single entry
        ptmp = []
        for plu in _results.plurals
          pluList = _.filter _results.plurals, (el) ->
            el.translationKey.id is plu.translationKey.id
          if pluList.length > 0
            for x in pluList  # remove related items form `_results.plurals` to optimize
              index = _.findIndex _results.plurals, x
              #console.log 'index', index
              _results.plurals.splice(index, 1)

            # segregate element
            #console.log "pluList", pluList
            segEl = {}
            segEl = _.merge {}, pluList[0].translationKey['__data'] # every single object of pluList has save same tanslationKey so we can get first one
            _defineProp(segEl, 'plurals', [])
            #console.log "segEl", segEl
            for z in pluList
              delete z.translationKey
              segEl.plurals.push z
              #console.log "segEl", segEl
            ptmp.push segEl

        console.log "ptmp", ptmp
        console.log "OOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOLD!!!!!!!!!!", _oldResults
        _results.plurals = ptmp # save almost done plurals, but still without namespaces

        # like plurals above we do not need to segregate strings, because every
        # single entry has just one translationKey (even if structure of
        # `_results.strings` is opposite of `_results.plurals`)

        # finding namespaces for
        queryOfTranslationKeysWithNamespaces = []
        console.log "_results.strings.length", _results.strings.length
        counter = 0
        for item in _oldResults.strings
          #index = _.findIndex _results.strings, item
          counter += 1
          queryOfTranslationKeysWithNamespaces.push _getTranslationKeyWithNamespaceAsync(item.translationKey)

        for item in _oldResults.plurals
          counter += 1
          console.log "item", item
          queryOfTranslationKeysWithNamespaces.push _getTranslationKeyWithNamespaceAsync(item.translationKey)

        console.log "all NOT REFACTORED translations: " + counter

        # save as JSON
        Q.all(queryOfTranslationKeysWithNamespaces).then (queryOfTranslationKeysWithNamespacesResponse) ->
          #for x in queryOfTranslationKeysWithNamespacesResponse
            #console.log "s", x
          #console.log "queryOfTranslationKeysWithNamespacesResponse.length", queryOfTranslationKeysWithNamespacesResponse.length
          _finalResult = {}
          if _results.plurals.length
            for item in _results.plurals
              # TODO give a programmer a choice to choose name of this variable (NUM).
              # NUM is just a name of variable used by angular-translate-interpolation-messageformat notation
              # Why NUM? 'cause I like numbers, and this reminds that plural is number of some sort ;)
              text = '{ NUM, plural, '
              for p in item.plurals
                key = _getKeyByValue(pluralFormList, p.pluralForm)
                text += key + '{' + p.translatedPhrase + '} '
              text += '}'
              finalKey =
              _finalResult[item.keyString] = text

          if _results.strings.length
            for x in _results.strings
              transKeyNamespaceIndex = _.findIndex queryOfTranslationKeysWithNamespacesResponse, (item) ->
                item.keyString == x.translationKey.keyString
              #console.log "x", x
              #console.log 'queryOfTranslationKeysWithNamespacesResponse[transKeyNamespaceIndex]', queryOfTranslationKeysWithNamespacesResponse[transKeyNamespaceIndex]
              if transKeyNamespaceIndex >= 0
                finalKey = queryOfTranslationKeysWithNamespacesResponse[transKeyNamespaceIndex].namespaces[0].namespace + '.' + x.translationKey.keyString
              else # if not have namespace
                console.log "EEEEEEEEEE for x", transKeyNamespaceIndex
                console.log "item.keystring", queryOfTranslationKeysWithNamespacesResponse[transKeyNamespaceIndex].keyString, ' = x.keystring',  x.translationKey.keyString
                finalKey = x.translationKey.keyString
              _finalResult[finalKey] = x.translatedPhrase
              #_finalResult[x.translationKey.keyString] = x.translatedPhrase

          return _finalResult # final Object
        , (e) ->
          console.log e
          throw e

        #return _results # helper array of prepared objects
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
        required:      true
      }
      {
        arg:          'projectLanguageId'
        description:  'One of languages assigned to requested project'
        type:         'string'
        required:      true
      }
    ]
    returns:
      arg: 'list'
      type: 'string'
  return
