angular.module('translation.controllers.translationModal', [
  'ui.router'
  'ngCookies'
  'data-table'
  'ngMessages'
  'ngAnimate'
  'lbServices'
  'translation.providers.userPermissionsSettings'
  'ui.bootstrap'
])

.controller 'TranslationModalController', ($uibModalInstance, Translation, TranslationKey, Namespace,
CurrentProjectService) ->
  vm  = this

  vm.getNamespaces = (val) ->
    Namespace.find(
      filter:
        where:
          namespace:
            like: "%#{val}%"
    ).$promise.then (success)->
      return success



  vm.translationKey              = {}
  vm.translationKey.keyString    = ''
  vm.translationKey.isPlural     = false



  _currentDate                      = new Date()
  vm.translation                    = {}
  vm.translation.description        = ''
  vm.translation.createdAt         = _currentDate
  vm.translation.updatedAt         = _currentDate

  _createNewNamespace = (namespace) ->
    _namespaceObject =
      parent_id: null
      namespace: namespace
      #TODO how should we create name?
      name: namespace
      #TODO mocked should be CurrentProjectService.getCurrentProject().id?
      projectId: 1
    Namespace.create(_namespaceObject).$promise.then (success) ->
      _createNewTranslationKey(success.id, vm.translationKey)
    , (error) ->
      console.log 'error while saving namespace'

  _createNewTranslationKey = (namespaceId, translationKeyObject) ->
    translationKeyObject.namespaceId  = namespaceId
    # TODO Do we really need this field since it's connected with namespace?
    translationKeyObject.projectId    = 1
    TranslationKey.create(translationKeyObject).$promise.then (success) ->
      _createNewTranslation(success.id, vm.translation)
    , (error) ->
      console.log 'error while saving translationKey'

  _createNewTranslation = (translationKeyId, translationObject) ->
    translationObject.translationsKeyId = translationKeyId
    translationObject.statusId          = 1
    # TODO it cannot be blank but it should be?
    translationObject.translatedPhrase  = "blank"
    # TODO mocked
    translationObject.languageId        = 1
    translationObject.lastModifiedBy    = 1
    translationObject.pluralForm        = null
    Translation.create(translationObject).$promise.then () ->
      $uibModalInstance.close()
    , (error) ->
      console.log 'error while saving translation'

  vm.ok = ->
    Namespace.find(
      filter:
        where:
          namespace: vm.namespace
    ).$promise.then (success)->
      if success.length is 1
        _createNewTranslationKey(success[0].id, vm.translationKey)
      else
        _createNewNamespace(vm.namespace)
    , (error) ->
      console.log "something went wrong!"


  vm.cancel = ->
    $uibModalInstance.close()


  return vm
