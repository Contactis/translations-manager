angular.module('translation.directives.trEditTable', [
  'smart-table'
])


.directive 'trEditTable', ($compile, $timeout, Translation, LanguageService, toastr) ->

  submitted = false

  #TODO loopback upsert is not working with relations 'belongs to', probably we should create our own backend to avoid
  #TODO deleting translate
  _updateHelper = (id, translate) ->
    Translation.deleteById({ id: id }).$promise.then () ->
      Translation.create(translate).$promise.then (success) ->
        translate.id = success.id


  _enableSaving = () ->
    submitted = false
    return


  _disableSaving = () ->
    submitted = true
    return


  updateTranslation = (translate, translationKey) ->

    if translate.id is undefined
      #case translate was not created already
      translate.pluralForm          = null
      translate.translationsKeyId   = translationKey.id
      translate.languageId          = LanguageService.getTranslationLanguageId()
      #TODO lastmodify mocked
      translate.lastModifiedBy      = 1
      translate.statusId            = 2

      Translation.create(translate).$promise.then (success) ->
        translate.id = success.id
        toastr.success 'New translation has been saved'
    else
      translate.statusId = 2
      _updateHelper translate.id, translate
      toastr.success 'Translation has been updated'


  linkerFn = (scope, element, attrs) ->

    if scope.translateVal is undefined
      scope.translateVal = {}

    scope.saveOnBlur = () ->
      if submitted is false
        updateTranslation(scope.translateVal, scope.translateObject)
      return


    scope.saveOnEnter = () ->
      if submitted is false
        updateTranslation(scope.translateVal, scope.translateObject)
        _disableSaving()
      return


    scope.prepareFocus = () ->
      _enableSaving()
      return

    return


  return {
    require:      '^?stTable'
    templateUrl:  'directives/trEditTable/trEditTable.tpl.html'
    link:         linkerFn
    replace:      true
    scope:
      translateVal:     '='
      translateObject:  '='
  }



