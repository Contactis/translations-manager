angular.module('translation.directives.trProjectSettingsProjectLanguages', [
  'lbServices'
  'toastr'
  'translation.services.helper'
  'translation.services.current-project'
  'translation.directives.trWaitingSpinnerSpan'
  'translation.directive.trProjectLanguagesSidePicker'
  'lodash'
])

.directive 'trProjectSettingsProjectLanguages', ($filter, $q, toastr, \
ProjectLanguage, TranslationKey, HelperService, _) ->
  restrict:       'EA'
  replace:        true
  templateUrl:    'directives/trProjectSettingsProjectLanguages/trProjectSettingsProjectLanguages.tpl.html'
  scope:
    currentProject:     '=' # just current project object
    projectLanguages:   '=' # all entites from ProjectLanguage pivot table
    availableLanguages: '=' # all languages available in TR
  link: (scope, element, attrs, ctrl) ->
    if angular.isUndefined(scope.projectLanguages) then throw new Error ('Missing projectLanguages data')
    if angular.isUndefined(scope.currentProject) then throw new Error ('Missing currentProject data')
    if angular.isUndefined(scope.availableLanguages) then throw new Error ('Missing availableLanguages data')


    # default value for validation checking
    scope.submitted = false

    # for checking scope.languageRemoveErrors
    scope.isPending = false

    # custom variable to temporarly save if removing language for current project has defined translations
    scope.languageRemoveErrors = []

    # Contain lists of languages modified and returned from trSidePicker directive
    scope.choosenLanguages  = [] # NOTE: need to be empty array!
    scope.leftLanguages     = [] # NOTE: need to be empty array!


    # execute after defined, to refresh languages for current project
    (_partitionCurrentProjectLanguages = () ->
      scope.currentProjectLanguages = _.where(scope.projectLanguages, {'projectId': scope.currentProject.id})
      return
    )(@)

    _getTranslationsForCurrentProject = () ->
      deferred = $q.defer()

      TranslationKey.find
        filter:
          include: [
            'translations'
          ]
          where:
            projectId: scope.currentProject.id
      .$promise.then (translationKeyResponse) ->
        deferred.resolve(translationKeyResponse)
      , (translationKeyError) ->
        deferred.reject(translationKeyError)
      return deferred.promise


    # returns    {Array}  Array of languages that has min 1 translation defined
    _checkIfLangagesHaveTranslations = () ->
      counter = {}
      for w in scope.leftLanguages
        counter[w.id] = 0

      deferred = $q.defer()
      _getTranslationsForCurrentProject().then (translationsResponse) ->
        for a in translationsResponse
          for t in a.translations
            # console.log "t", t
            for j in scope.leftLanguages
              if j.id is t.languageId then counter[j.id] += 1
        deferred.resolve(counter)
      , (translationsError) ->
        console.log "error", translationsError
        deferred.reject(translationsError)
      return deferred.promise


    _updateProjectLanguages = () ->
      ProjectLanguage.find().$promise.then (projectLanguagesResponse) ->
        scope.projectLanguages = projectLanguagesResponse
        _partitionCurrentProjectLanguages()
      , (projectLanguagesError) ->
        toastr.error "Cound't update currentProject"
        $log.error "Error:", projectLanguagesError
      return


    # @private
    # @description  simple assinginig result to variable to avoid multiple method call
    _partitionArray = () ->
      HelperService.partitionGreaterArrayByParameter(scope.projectLanguages, \
        scope.currentProjectLanguages, 'id')


    scope.selectedData    = _partitionArray()[0]
    scope.unselectedData  = _partitionArray()[1]


    # @private
    # @method       _buildProjectLanguageModel
    # @description  Build Array of objects which can be used to save data to the
    #               backend
    # @returns      {Array}
    _buildProjectLanguageModel = () ->
      _tmpArray = []
      if scope.choosenLanguages.length > 0
        for x in scope.choosenLanguages
          _tmpObj =
            projectId:  scope.currentProject.id
            languageId: x.id
          _tmpArray.push _tmpObj
      return _tmpArray


    # @private
    # @method       _removeAllRelatedEntities
    # @description  removing all related entities from database
    # @returns      {Promise}
    _removeAllRelatedEntities = () ->
      _removingPromises = []
      deferred = $q.defer()

      # TODO: reduce promisses
      for x in scope.selectedData
        _removingPromises.push ProjectLanguage.deleteById({id: x.id}).$promise

      $q.all(_removingPromises).then (success) ->
        msg = $filter('translate')('APP.FRONTEND_MESSAGES.USER_ASSIGNMENT.REMOVED_ENTITIES_SUCCESSFULLY')
        deferred.resolve msg
      , (e) ->
        msg = $filter('translate')('APP.FRONTEND_MESSAGES.USER_ASSIGNMENT.REMOVED_ENTITIES_FAILED')
        deferred.reject msg
      return deferred.promise


    # @private
    # @method       _savingAllNewEntities
    # @description  save all related entities to the database
    # @returns      {Promise}
    _savingAllNewEntities = () ->
      _newPromises = []
      deferred = $q.defer()

      list = _buildProjectLanguageModel() # generate array model for backend
      if list.length > 0
        for y in list
          _newPromises.push ProjectLanguage.create(y).$promise

      $q.all(_newPromises).then (success) ->
        msg = $filter('translate')('APP.FRONTEND_MESSAGES.SUCCESSFULLY_SAVED_THE_DATA')
        deferred.resolve msg
      , (error) ->
        msg = $filter('translate')('APP.FRONTEND_MESSAGES.ERROR_OCCURED_WHILE_SAVING_THE_DATA') +
            ' ' + $filter('translate')('APP.FRONTEND_MESSAGES.TRY_AGAIN_LATER') +
            ' Error detail:' + error
        deferred.reject msg
      return deferred.promise


    # @public
    # @method       scope.saveProjectLanguages
    # @description  Removing and saving all related entities
    scope.saveProjectLanguages = () ->
      scope.isPending = true
      _checkIfLangagesHaveTranslations().then (checkResponse) ->
        console.log "checkResponse", checkResponse
        bool = false
        Object.keys(checkResponse).forEach (key, index) ->
          if checkResponse[key] > 0
            bool = true
            index = _.findIndex(scope.availableLanguages, (item) ->
              item.id is parseInt(key, 10))
            toastr.warning  'Language "' + scope.availableLanguages[index].nameNative + \
              '" has ' + checkResponse[key] + ' translations, so cannot be removed.'

        if !bool
          _removeAllRelatedEntities().then (removeAllRelatedEntitiesResponse) ->
            toastr.success removeAllRelatedEntitiesResponse
            _savingAllNewEntities().then (savingAllNewEntitiesResponse) ->
              toastr.success savingAllNewEntitiesResponse
              _updateProjectLanguages()
              scope.isPending = false
            , (removeAllRelatedEntitiesError) ->
              toastr.error removeAllRelatedEntitiesError
              scope.isPending = false
          , (savingAllNewEntitiesError) ->
            toastr.error savingAllNewEntitiesError
            scope.isPending = false
        else
          scope.isPending = false
      , (checkError) ->
        toastr.error "Some error occured while checking if choosen languagages have defined translations"
        console.log "checkIfLangagesHaveTranslations", checkError
        scope.isPending = false
      return

    return
