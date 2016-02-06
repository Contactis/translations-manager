angular.module('translator.directive.trEditTable', [
  'smart-table'
])


.directive 'trEditTable', ($compile, $timeout, Translation, LanguageService, toastr) ->

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
        toastr.success 'Translate updated!'
    else
      translate.statusId = 2
      _updateHelper translate.id, translate
      toastr.success 'Translate updated!'
  #TODO loopback upsert is not working with relations 'belongs to', probably we should create our own backend to avoid
  #TODO deleting translate
  _updateHelper = (id, translate) ->
    Translation.deleteById({ id: id }).$promise.then (succes) ->
      Translation.create(translate).$promise.then (succes) ->
        translate.id = succes.id


  linker = (scope, element, attrs) ->
    scope.update = updateTranslation


    return


  return {
  require: '^?stTable'
  template: '<input data-ng-blur="update(translateVal, translateObject)" class="form-control" type="text"
  data-ng-model="translateVal.translatedPhrase">'
  link: linker
  replace: true
  scope:
    translateVal:'='
    translateObject:'='
  }



