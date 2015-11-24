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



  vm.translationKey            = {}
  vm.translationKey.keyString  = ''
  vm.translationKey.isPlural   = false



  _currentDate                = new Date()
  vm.translation              = {}
  vm.translation.description  = ''
  vm.translation.createdAt    = _currentDate
  vm.translation.updatedAt    = _currentDate

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

  vm.ok = ->
    Namespace.find(
      filter:
        where:
          namespace: vm.namespace
    ).$promise.then (success)->

      CurrentProjectService.getCurrentProject().then (response) ->
        if success.length is 1
          _createNewTranslationKey(success[0].id, vm.translationKey, response)
        else
          _createNewNamespace(vm.namespace, response)
      , (error) ->
      console.log 'error while getting project', error

    , (error) ->
      console.log 'something went wrong!', error


  vm.cancel = ->
    $uibModalInstance.close()


  return vm
