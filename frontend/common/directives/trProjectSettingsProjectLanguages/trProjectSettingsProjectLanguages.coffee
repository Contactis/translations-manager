angular.module('translation.directives.trProjectSettingsProjectLanguages', [
  'lbServices'
  'toastr'
  'translation.services.helper'
  'translation.services.current-project'
  'translation.directive.trProjectLanguagesSidePicker'
  'lodash'
])

.directive 'trProjectSettingsProjectLanguages', ($filter, $q, toastr, ProjectLanguage, HelperService, _) ->
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

    # Contain list of languages modified and returned from trSidePicker directive
    scope.choosenLanguages = [] # NOTE: need to be empty array!


    # execute after defined, to refresh languages for current project
    (_partitionCurrentProjectLanguages = () ->
      scope.currentProjectLanguages = _.where(scope.projectLanguages, {'projectId': scope.currentProject.id})
      return
    )(@)


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

      $q.all().then (success) ->
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
      _removeAllRelatedEntities().then (removeAllRelatedEntitiesResponse) ->
        toastr.success removeAllRelatedEntitiesResponse
        _savingAllNewEntities().then (savingAllNewEntitiesResponse) ->
          toastr.success savingAllNewEntitiesResponse
          _updateProjectLanguages()
        , (removeAllRelatedEntitiesError) ->
          toastr.error removeAllRelatedEntitiesError
      , (savingAllNewEntitiesError) ->
        toastr.error savingAllNewEntitiesError
      return

    return
