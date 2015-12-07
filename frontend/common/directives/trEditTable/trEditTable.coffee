angular.module('translator.directive.trEditTable', [
  'smart-table'
])


.directive 'trEditTable', ($compile, $timeout, Translation, LanguageService, toastr) ->
  inputTemplate = '<input ng-model="translateVal.translatedPhrase"/>'
  tdTemplate    = '<span ng-bind="translateVal.translatedPhrase"></span>'


  getTemplate = (contentType) ->
    template = ''

    switch contentType
      when 'input'
        template = inputTemplate
      when 'td'
        template = tdTemplate

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
    else
      translate.statusId = 2
    Translation.upsert(translate).$promise.then (succes) ->
      translate.id = succes.id

  cleanBindHelper = (_lock, element, scope)->
    _lock=true
    element.html(getTemplate('td')).show()
    scope.$apply ->
      $compile(element.contents())(scope)
    updateTranslation(scope.translateVal, scope.translateObject)

    element.on 'click', (e) ->
      if _lock
        element.html(getTemplate('input')).show()
        scope.$apply ->
          $compile(element.contents())(scope)
          element[0].querySelector('input').focus()
        _lock=false

  prepareCleanInput = (element, scope) ->
    _lock = true
    scope.translateVal = {}
    scope.translateVal.translatedPhrase = ""

    element.html(getTemplate('input')).show()
    $compile(element.contents())(scope)

    element.bind "focusout", ->
      if scope.translateVal.translatedPhrase != ""
        cleanBindHelper _lock, element, scope
        toastr.success 'Translate updated!'

    element.bind "keydown", (event) ->
      if event.which==13
        element[0].querySelector('input').blur()

  bindHelper = (element, scope) ->
    element.html(getTemplate('td')).show()
    scope.$apply ->
      $compile(element.contents())(scope)
    updateTranslation(scope.translateVal)
    event.preventDefault()

    return false

  prepareInput = (element, scope) ->
    _lock = false
    element.on 'click', (e) ->
      if !_lock
        element.html(getTemplate('input')).show()

        element.unbind('focusout')
        element.unbind('keydown')

        element.bind "focusout", () ->
          if scope.translateVal.translatedPhrase != ""
            _lock = bindHelper element, scope
            toastr.success 'Translate updated!'

        element.bind "keydown", (event) ->
          if(event.which==13)
            element[0].querySelector('input').blur()

        scope.$apply ->
          $compile(element.contents())(scope)
          element[0].querySelector('input').focus()

      _lock = true





  linker = (scope, element, attrs) ->

    if scope.translateVal is undefined
      prepareCleanInput(element, scope)
    else
      prepareInput(element, scope)

    scope.$watch 'translateVal', (newVal, oldVal) ->
      if newVal is undefined
        prepareCleanInput(element, scope)
        toastr.warning 'Translate deleted'
    , true

    return


  return {
  require: '^?stTable'
  template: '<span> {{ translateVal.translatedPhrase }} </span>'
  link: linker
  scope:
    translateVal:'='
    translateObject:'='
  }



