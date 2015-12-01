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


  vm.isPending      = true
  vm.translationKey =
    keyString:  ''
    isPlural:   'string'
  vm.translation    =
    description:    ''
    createdAt:      _currentDate
    updatedAt:      _currentDate
    lastModifiedBy: AccountService.getData('id')
  vm.plurals        = null
  vm.currentProject = {}
  vm.meta =
    projectLanguage: ""


  if $cookies.get(_cookieName)
    _tmp = $cookies.get(_cookieName)
    vm.translationKey.isPlural      = _tmp.isPlural
    vm.namespace                    = _tmp.namespace
    vm.translationKey.keyString     = _tmp.keyString
    vm.translation.translatedPhrase = _tmp.translatedPhrase
    vm.translation.description      = _tmp.description
    for x in _tmp.plurals
      index = _.findIndex vm.plurals, (item) ->
        item.id is x.id
      vm.plurals[index] = x.pluralTranslationString


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
    , (errorPlurals) ->
      $log.error "error plurals:", errorPlurals
      vm.isPending = false
  , (currentProjectError) ->
    $log.error 'Error occured while getting current project', currentProjectError
    vm.isPending = false

  # @private
  # @method     _saveCookie
  _saveCookie = ->
    _tmpObj =
      isPlural:         vm.translationKey.isPlural
      namespace:        vm.namespace
      keyString:        vm.translationKey.keyString
      translatedPhrase: vm.translation.translatedPhrase
      description:      vm.translation.description
      plurals:          []
    for plural in vm.plurals
      _tmpObj.plurals.push plural
    $cookies.put _cookieName, _tmpObj

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
    .$promise.then (success)->
      return success


  # @public
  # @method       vm.isPlural
  # @description  Checks if `vm.translationKey.isPlural` select option points
  #               at 'plural'
  # @returns      {Bool}
  vm.isPlural = ->
    if vm.translationKey.isPlural is 'plural'
      return true
    else
      return false


  # @private
  # @method       _createNewNamespace
  # @param        {String}  namespace  indexkey string of new namespace for programmers;
  # @param        {Object}  project    project object where namespace should be assigned
  # @description  Creating new namespace for project
  # @returns      {Object}  new namespace object or error
  _createNewNamespace = (namespace, project) ->
    _namespaceObject =
      parent_id:    null
      namespace:    namespace
      description:  "" # is not required
      projectId:    project.id
    _deferred = $q.defer()
    Namespace.create(_namespaceObject).$promise.then (success) ->
      $log.info "new namespace object", success
      _deferred.resolve success
    , (error) ->
      $log.error 'Error occured while saving namespace', error
      _deferred.reject 'Error occured while saving namespace'
    return _deferred.promise


  # @private
  # @method       _createNewTranslationKey
  # @param        {String}  namespaceId
  # @param        {Object}  translationKeyObject
  # @param        {Object}  project                 object of given project
  # @description  Creating new translation-key for translation object
  # @returns      {Object}  new translation-key object or error
  _createNewTranslationKey = (namespaceId, translationKeyObject, project) ->
    translationKeyObject.namespaceId  = namespaceId
    translationKeyObject.projectId    = project.id
    TranslationKey.create(translationKeyObject).$promise.then (translationKeySuccess) ->
      return translationKeySuccess
    , (translationKeyError) ->
      $log.error 'Error while saving translationKey', translationKeyError
      return translationKeyError


  _createNewTranslation = (translationKeyId, translationObject, project) ->
    translationObject.translationsKeyId = translationKeyId
    translationObject.statusId          = 1
    translationObject.languageId        = project.defaultLanguageId
    translationObject.lastModifiedBy    = 1
    translationObject.pluralForm        = null
    Translation.create(translationObject).$promise.then (translationSuccess) ->
      return translationSuccess
    , (translationError) ->
      $log.error 'Error while saving translation', translationError
      return translationError


  # @private
  # @param        {Object}  namespace
  _createNewTranslationKeyAndTranslation = (namespace) ->
    _createNewTranslationKey(namespace.id, vm.translationKey, vm.currentProject).then (translationKeyResponse) ->
      _createNewTranslation(translationKeyResponse.id, vm.translation, vm.currentProject).then (translationResponse) ->
        $cookies.remove _cookieName
        toastr.success "Created translation successfully"
        $rootScope.$emit 'reloadProgrammerTranslationList'
        $uibModalInstance.close()


  # @public
  # @method       vm.saveTranslationKey
  # @description  Create new translation with `namespace`, `translation-key`
  # @returns      {None}  none
  vm.saveTranslationKey = ->
    _saveCookie() #save object in cookies

    Namespace.find
      filter:
        where:
          namespace: vm.namespace
    .$promise.then (namespaceResponse) ->
      $log.info "namespaceResponse", namespaceResponse
      if namespaceResponse.length # namespace exsists
        _createNewTranslationKeyAndTranslation(namespaceResponse[0].id)
      else
        _createNewNamespace(vm.namespace, vm.currentProject).then (namespaceCreatedResponse) ->
          _createNewTranslationKeyAndTranslation(namespaceCreatedResponse)
          return
    , (namespaceError) ->
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
    vm.translationKey.isPlural      = 'string'
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
