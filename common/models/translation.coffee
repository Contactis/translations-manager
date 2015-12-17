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

    # Check if
    #  - project exsist
    #  - language for project exsist
    #  - is there any translation (translationKeys) for project


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
          id:         translation.translationsKeyId
          projectId:  projectId # projectId from main method
      , (err, result) ->
        if err
          _deferred.reject err
        else
          tmp = {}
          _.merge tmp, translation # native lodash __data object
          tmp['translationKey'] = result
          _deferred.resolve tmp
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
          id:         translationKeyObj.namespaceId
          projectId:  projectId
      , (err, result) ->
        if err
          _deferred.reject err
        else
          obj = _.merge {}, translationKeyObj['__data']
          obj['namespaces'] = []
          obj.namespaces.push result
          _deferred.resolve obj
      return _deferred.promise


    _getTranslations = () ->
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


    _getTranslations().then (translationsResponse) ->
      translationKeysQuery = []
      for x in translationsResponse
        translationKeysQuery.push _getTranslationKeyAsync(x)

      Q.all(translationKeysQuery).then (translationKeysQueryResponse) ->
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

        # sort for plurals that refers to single entry
        ptmp = []
        p = _results.plurals.length - 1
        while p >= 0
          plu = _results.plurals[p]
          pluList = _.filter _results.plurals, (el) -> #find plurals with same translationKey.id
            el.translationKey.id is plu.translationKey.id
          if pluList.length > 0
            i = pluList.length
            while i--
              index = _.findIndex _results.plurals, pluList[i]
              _results.plurals.splice(index, 1)    # removing to reduce table >
              p-- # if we splice from current loop (while p) we need to deincrement to mach current index of this loop

            # segregate element
            segEl = {}
            segEl = _.merge {}, pluList[0].translationKey['__data'] # every single object of pluList has save same tanslationKey so we can get first one
            _defineProp(segEl, 'plurals', [])
            z = pluList.length
            while z--
              pluListItem = pluList[z]
              delete pluListItem.translationKey
              segEl.plurals.push pluListItem
            ptmp.push segEl
          p -= 1 # increment by the negative

        _results.plurals = ptmp # save almost done plurals, but still without namespaces


        # like plurals above we do not need to segregate strings, because every
        # single entry has just one translationKey (even if structure of
        # `_results.strings` is opposite of `_results.plurals`)

        # finding related namespaces
        queryOfTranslationKeysWithNamespaces = []
        for item in _oldResults.strings
          queryOfTranslationKeysWithNamespaces.push _getTranslationKeyWithNamespaceAsync(item.translationKey)
        for item in _oldResults.plurals # we work on not refactored because its build is just like _results.string
          queryOfTranslationKeysWithNamespaces.push _getTranslationKeyWithNamespaceAsync(item.translationKey)


        # save as JSON
        Q.all(queryOfTranslationKeysWithNamespaces).then (queryOfTranslationKeysWithNamespacesResponse) ->
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
              finalKey = ''
              indexNamespace = _.findIndex queryOfTranslationKeysWithNamespacesResponse, (q) ->
                item.id  == q.id
              if indexNamespace isnt -1
                finalKey += queryOfTranslationKeysWithNamespacesResponse[indexNamespace].namespaces[0].namespace + '.'
              finalKey += item.keyString
              _finalResult[finalKey] = text

          if _results.strings.length
            for x in _results.strings
              transKeyNamespaceIndex = _.findIndex queryOfTranslationKeysWithNamespacesResponse, (item) ->
                item.id == x.translationKey.id # compare only id of translationKeys
              finalKey = ''
              if transKeyNamespaceIndex isnt -1
                finalKey += queryOfTranslationKeysWithNamespacesResponse[transKeyNamespaceIndex].namespaces[0].namespace + '.'
              finalKey += x.translationKey.keyString
              _finalResult[finalKey] = x.translatedPhrase

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
