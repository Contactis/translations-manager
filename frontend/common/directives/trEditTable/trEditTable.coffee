angular.module('translator.directive.trEditTable', [
  'smart-table'
])

.directive 'trEditTable', ($compile, $timeout, Translation, LanguageService, toastr) ->

  _generateRandomId = () ->
    return Math.random().toString(36).substr(2, 10)


  _getTemplate = (contentType, id) ->
    return switch contentType
      when 'input'
        '<input id="' + id + '" ng-model="translateVal.translatedPhrase" />'
      when 'td'
        '<input id="' + id + '" ng-bind="translateVal.translatedPhrase"></span>'
      else
        ''


  _updateTranslation = (translate, translationKey) ->
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


  _cleanBindHelper = (lock, element, scope)->
    lock = true
    element.html(_getTemplate('td', scope.virtualId)).show()
    console.log "element.html(_getTemplate('td', scope.virtualId))", element.html(_getTemplate('td', scope.virtualId))
    scope.$apply ->
      $compile(element.contents())(scope)
    _updateTranslation(scope.translateVal, scope.translateObject)

    element.on 'click', (e) ->
      if lock
        element.html(_getTemplate('input', scope.virtualId)).show()
        scope.$apply ->
          $compile(element.contents())(scope)
          element[0].querySelector('input' + '#' + scope.virtualId).focus()
        lock = false


  _prepareCleanInput = (element, scope) ->
    lock = true
    scope.translateVal = {}
    scope.translateVal.translatedPhrase = ""

    element.html(_getTemplate('input', scope.virtualId)).show()
    $compile(element.contents())(scope)

    element.bind "focusout", ->
      if scope.translateVal.translatedPhrase != ""
        _cleanBindHelper(lock, element, scope)

    element.bind "keydown", (event) ->
      if event.which==13
        element[0].querySelector('input' + '#' + scope.virtualId).blur()


  _bindHelper = (element, scope) ->
    element.html(_getTemplate('td', scope.virtualId)).show()
    scope.$apply ->
      $compile(element.contents())(scope)
    _updateTranslation(scope.translateVal)
    event.preventDefault()

    return false


  _prepareInput = (element, scope) ->
    lock = false
    element.on 'click', (e) ->
      console.log "element is clicked", e
      if !lock
        element.html(_getTemplate('input', scope.virtualId)).show()

        console.log "element: ", element.html(_getTemplate('input', scope.virtualId))

        element.unbind('focusout')
        element.unbind('keydown')

        element.bind "focusout", () ->
          if scope.translateVal.translatedPhrase != ""
            lock = _bindHelper(element, scope)

        element.bind "keydown", (event) ->
          if(event.which==13)
            element[0].querySelector('input' + '#' + scope.virtualId).blur()

        scope.$apply ->
          $compile(element.contents())(scope)
          element[0].querySelector('input' + '#' + scope.virtualId).focus()

      lock = true


  linkerFn = (scope, element, attrs) ->
    scope.virtualId = _generateRandomId()
    # console.log scope.virtualId

    if scope.translateVal is undefined
      _prepareCleanInput(element, scope)
      console.log "_prepareCleanInput"
    else
      _prepareInput(element, scope)
      console.log "_prepareInput"

    scope.$watch 'translateVal', (newVal, oldVal) ->
      if newVal is undefined
        _prepareCleanInput(element, scope)
        toastr.warning 'Translation deleted'
    , true
    return


  return {
  require: '^?stTable'
  replace: true
  template: '<input id="{{ virtualId }}" class="form-control" value="{{ translateVal.translatedPhrase }}" />'
  link: linkerFn
  scope:
    translateVal:'='
    translateObject:'='
  }



