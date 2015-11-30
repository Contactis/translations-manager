# # Add Translation Key Modal

# @module       translation.controllers.addTranslationKey
angular.module('translation.controllers.addTranslationKey', [
  'ui.router'
  'ngCookies'
  'data-table'
  'ngMessages'
  'ngAnimate'
  'lbServices'
  'ui.bootstrap'
  'translation.providers.userPermissionsSettings'
  'translation.directives.trWaitingSpinnerDiv'
])

.controller 'AddTranslationKeyController', ($timeout, $log, $uibModalInstance, Translation, LanguageTranslation,
TranslationKey, Namespace, CurrentProjectService) ->
  vm  = this

  _currentDate                  = new Date()

  vm.isPending                  = true
  vm.translationKey             = {}
  vm.translationKey.keyString   = ''
  vm.translationKey.isPlural    = 'string'
  vm.translation                = {}
  vm.translation.description    = ''
  vm.translation.createdAt      = _currentDate
  vm.translation.updatedAt      = _currentDate
  vm.plurals                    = null

  vm.currentProject = {}

  # Loading plurals for current language
  CurrentProjectService.getCurrentProject().then (responseCurrentProject) ->
    $log.info "CurrentProjectService", responseCurrentProject
    vm.currentProject = responseCurrentProject
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
  , (errorCurrentProject) ->
    $log.error "error during retriving current project"
    vm.isPending = false

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
  #               at 'plurar'
  # @returns      {Bool}
  vm.isPlural = ->
    if vm.translationKey.isPlural is 'plural'
      return true
    else
      return false


  _createNewNamespace = (namespace, project) ->
    _namespaceObject =
      parent_id: null
      namespace: namespace
      #TODO name - useless field?
      name: namespace
      projectId: project.id
    Namespace.create(_namespaceObject).$promise.then (success) ->
      _createNewTranslationKey(success.id, vm.translationKey, project)
    , (error) ->
      console.log 'error while saving namespace', error


  _createNewTranslationKey = (namespaceId, translationKeyObject, project) ->
    translationKeyObject.namespaceId  = namespaceId
    # TODO Do we really need this field since it's connected with namespace?
    translationKeyObject.projectId    = 1
    TranslationKey.create(translationKeyObject).$promise.then (success) ->
      _createNewTranslation(success.id, vm.translation, project)
    , (error) ->
      console.log 'error while saving translationKey', error


  _createNewTranslation = (translationKeyId, translationObject, project) ->
    translationObject.translationsKeyId = translationKeyId
    translationObject.statusId          = 1
    translationObject.languageId        = project.defaultLanguageId
    translationObject.lastModifiedBy    = 1
    translationObject.pluralForm        = null
    Translation.create(translationObject).$promise.then () ->
      $uibModalInstance.close()
    , (error) ->
      console.log 'error while saving translation'


  vm.saveTranslationKey = ->
    Namespace.find
      filter:
        where:
          namespace: vm.namespace
    .$promise.then (success)->

      CurrentProjectService.getCurrentProject().then (response) ->
        if success.length is 1
          _createNewTranslationKey(success[0].id, vm.translationKey, response)
        else
          _createNewNamespace(vm.namespace, response)
      , (e) ->
        console.log 'error while getting project', e

    , (error) ->
      console.log 'something went wrong!', error


  # @method       cancel
  # @description  Close modal of adding index key
  vm.cancel = ->
    $uibModalInstance.close()


  return vm
