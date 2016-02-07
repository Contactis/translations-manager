angular.module('translation.directives.trEditTable', [
  'smart-table'
])


.directive 'trEditTable', ($compile, $timeout, Translation, LanguageService, toastr) ->

  submitted = false

  #TODO loopback upsert is not working with relations 'belongs to', probably we should create our own backend to avoid
  #TODO deleting translate
  _updateHelper = (id, translate) ->
    Translation.deleteById({ id: id }).$promise.then (succes) ->
      Translation.create(translate).$promise.then (succes) ->
        translate.id = succes.id


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
      translate.updateAt            = moment().format()
      translate.createdAt           = moment().format()

      Translation.create(translate).$promise.then (succes) ->
        translate.id = succes.id
        toastr.success 'New translation has been saved'
    else
      translate.statusId = 2
      _updateHelper translate.id, translate
      toastr.success 'Translation has been updated'


  linkerFn = (scope, element, attrs) ->
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



