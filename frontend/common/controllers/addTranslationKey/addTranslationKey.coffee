# # Add Translation Key Modal

# @module       translation.controllers.addTranslationKey
angular.module('translation.controllers.addTranslationKey', [
  'ui.router'
  'pascalprecht.translate'
  'ngCookies'
  'data-table'
  'ngMessages'
  'ngAnimate'
  'lbServices'
  'toastr'
  'ui.bootstrap'
  'translation.providers.userPermissionsSettings'
  'translation.services.account'
  'translation.services.plural'
  'translation.directives.trWaitingSpinnerDiv'
])

.controller 'AddTranslationKeyController', ($rootScope, $timeout, $log, $q, toastr, $cookies,
$uibModalInstance, Translation, LanguageTranslation, TranslationKey, Namespace,
CurrentProjectService, AccountService, PluralService) ->
# $scope is used only for emit

  vm  = this

  _cookieName       = "tmpTranslationKey"
  _currentDate      = new Date()


  vm.isPending            = true
  vm.isPluralFormsLoaded  = false
  vm.translationKey =
    keyString:  ''
    type:       'string'
  vm.translation    =
    description:    ''
    createdAt:      _currentDate
    updatedAt:      _currentDate
    lastModifiedBy: AccountService.getData('id')
  vm.plurals        = null
  vm.currentProject = {}
  vm.meta =
    projectLanguage: ""


  # Loading plurals for current language during opening modal
  CurrentProjectService.getCurrentProject().then (responseCurrentProject) ->
    $log.info "CurrentProjectService", responseCurrentProject
    vm.currentProject = responseCurrentProject
    vm.meta.projectLanguage = vm.currentProject.defaultLanguage.nameNative + ', ' + \
      vm.currentProject.defaultLanguage.ietfCode
    LanguageTranslation.find
      filter:
        where:
          languageId: vm.currentProject.defaultLanguageId
    .$promise.then (responsePlurals) ->
      vm.plurals = responsePlurals
      vm.isPending = false
      vm.isPluralFormsLoaded = true
    , (errorPlurals) ->
      $log.error "Error while loading plural forms for currently translated language: ", errorPlurals
      vm.isPending = false
      isPluralFormsLoaded = true
  , (currentProjectError) ->
    $log.error 'Error occured while getting current project: ', currentProjectError
    vm.isPending = false
    isPluralFormsLoaded = true


  # @public
  # @method       vm.getNamespaces
  # @getter
  # @param        {String}  val  value with givin string to search
  # @description  Gets (typeahead) namespaces by giving value.
  # @returns      {Promise}
  vm.getNamespaces = (val) ->
    Namespace.find
      filter:
        where:
          namespace:
            like: "%#{val}%"
          projectId: vm.currentProject.id
    .$promise.then (success)->
      return success


  # @public
  # @method       vm.isPlural
  # @description  Checks if `vm.translationKey.type` select option points
  #               at 'plural'
  # @returns      {Bool}
  vm.isPlural = ->
    if vm.translationKey.type is 'plural'
      return true
    else
      return false


  # @private
  # @method       _createNewNamespace
  # @param        {String}  namespace  indexkey string of new namespace for programmers;
  # @param        {Object}  project    project object where namespace should be assigned
  # @description  Creating new namespace for project
  # @returns      {Object}  new namespace object or error msg
  _createNewNamespace = (namespace, project) ->
    _namespaceObject =
      parent_id:    null
      namespace:    namespace
      description:  "" # is not required
      projectId:    project.id
    _deferred = $q.defer()
    Namespace.create(_namespaceObject).$promise.then (success) ->
      $log.info "new namespace object created: ", success
      _deferred.resolve success
    , (error) ->
      msg = 'Error occured while saving namespace'
      $log.error msg, error
      _deferred.reject msg
    return _deferred.promise


  # @private
  # @method       _createNewTranslationKey
  # @param        {String}  namespaceId
  # @param        {Object}  translationKeyObject
  # @param        {Object}  project                 object of given project
  # @param        {Object}  [isPlural=false]        flag for translation-key object that it is plural
  # @description  Creating new translation-key for translation object
  # @returns      {Object}  new translation-key object or error msg
  _createNewTranslationKey = (namespaceId, translationKeyObject, project, isPlural) ->
    translationKeyObject.isPlural     = if angular.isUndefined(isPlural) then false else true
    translationKeyObject.namespaceId  = namespaceId
    translationKeyObject.projectId    = project.id
    _deferred = $q.defer()
    TranslationKey.create(translationKeyObject).$promise.then (translationKeySuccess) ->
      $log.info "TranslationKey.created: ", translationKeySuccess
      _deferred.resolve translationKeySuccess
    , (translationKeyError) ->
      msg = 'Error while saving translationKey'
      $log.error msg, translationKeyError
      _deferred.reject msg
    return _deferred.promise


  # @private
  # @method       _createNewTranslation
  # @param        {String}  translationKeyId
  # @param        {Object}  translationObject
  # @param        {Object}  project             object of given project
  # @param        {Object}  pluralForm          plural form id which represents one of six potetial forms
  # @description  Creating new translation entry based on `tranlsation-key`
  # @returns      {Object}  new translation object or error msg
  _createNewTranslation = (translationKeyId, translationObject, project, pluralForm) ->
    translationObject.pluralForm        = if angular.isUndefined(pluralForm) then null else pluralForm
    translationObject.translationsKeyId = translationKeyId
    translationObject.statusId          = 1     # id of status is from TranslationStatuses (to_verify)
    translationObject.languageId        = project.defaultLanguageId
    _deferred = $q.defer()
    Translation.create(translationObject).$promise.then (translationSuccess) ->
      $log.info "new translation entry created: ", translationSuccess
      _deferred.resolve translationSuccess
    , (translationError) ->
      msg = 'Error while saving translation entry'
      $log.error msg, translationError
      _deferred.reject msg
    return _deferred.promise


  # @private
  # @param        {Object}    namespace   created or exsisted namespace object
  # @description  Create translation-key and translation entry for single indexkey String
  _createNewTranslationKeyAndTranslationString = (namespace) ->
    _createNewTranslationKey(namespace.id, vm.translationKey, vm.currentProject).then (translationKeyResponse) ->
      _createNewTranslation(translationKeyResponse.id, vm.translation, vm.currentProject).then (translationResponse) ->
        $cookies.remove _cookieName
        toastr.success "Created single translation string successfully"
        $rootScope.$emit 'reloadProgrammerTranslationList'
        $uibModalInstance.close()


  # @private
  # @method       _createNewTranslationKeyAndTranslationPlural
  # @param        {Object}    namespace   created or exsisted namespace object
  # @description  Create translation-key and translation entry for single indexkey String
  _createNewTranslationKeyAndTranslationPlural = (namespace) ->
    _createNewTranslationKey(namespace.id, vm.translationKey, vm.currentProject, true).then (translationKeyResponse) ->
      query = []
      vm.translation.translatedPhrase
      for x in vm.plurals
        vm.translation.translatedPhrase = x.pluralTranslationString
        translation = angular.copy vm.translation
        query.push _createNewTranslation(translationKeyResponse.id, translation, vm.currentProject, x.pluralForm)

      $q.all(query).then (resultsSuccess) ->
        $log.info resultsSuccess
        toastr.success "Created all translation plurals successfully"
        $rootScope.$emit 'reloadProgrammerTranslationList'
        $uibModalInstance.close()
      , (resultsError) ->
        $log.error "$q.all(query) for translation plurals failed"
        $uibModalInstance.close()


  # @public
  # @method       vm.saveTranslationKey
  # @description  Create new translation with `namespace`, `translation-key`
  # @returns      {None}  none
  vm.saveTranslationKey = ->
    vm.isPending = true
    Namespace.find
      filter:
        where:
          namespace: vm.namespace
          projectId: vm.currentProject.id
    .$promise.then (namespaceResponse) ->
      $log.info "namespaceResponse", namespaceResponse
      if namespaceResponse.length # namespace exsists
        if vm.isPlural()
          $log.info "plural! without creating new namespace"
          _createNewTranslationKeyAndTranslationPlural(namespaceResponse[0]) # plural
        else
          _createNewTranslationKeyAndTranslationString(namespaceResponse[0]) # string
        vm.isPending = false
        return
      else
        _createNewNamespace(vm.namespace, vm.currentProject).then (namespaceCreatedResponse) ->
          if vm.isPlural()
            $log.info "plural! with namespace created"
            _createNewTranslationKeyAndTranslationPlural(namespaceCreatedResponse) # plural
          else
            _createNewTranslationKeyAndTranslationString(namespaceCreatedResponse) # string
          vm.isPending = false
          return
        , (namespaceCreatedError) ->
          $log.error "Something went wrong with creating new translation key", namespaceCreatedError
          vm.isPending = false
          return
    , (namespaceError) ->
      vm.isPending = false
      $log.error 'Something went wrong while search for a namespace!', namespaceError
      return


  # @public
  # @method       cancel
  # @description  Close modal of adding index key
  vm.cancel = ->
    $uibModalInstance.close()


  # @public
  # @method       cancel
  # @description  Close modal of adding index key
  vm.cleanForm = ->
    vm.translationKey.type          = 'string'
    vm.namespace                    = ""
    vm.translationKey.keyString     = ""
    for x in vm.plurals
      x.pluralTranslationString     = ""
    vm.translation.translatedPhrase = ""
    vm.translation.description      = ""


  # @public
  # @method       vm.getNameOfPlural
  # @description  Get name of plural with given id
  vm.getNameOfPlural = (id) ->
    return PluralService.getPlural(id).name


  return vm
