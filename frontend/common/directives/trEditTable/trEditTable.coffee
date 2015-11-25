angular.module('translator.directive.trEditTable', [
  'smart-table'
])


.directive 'trEditTable', ($compile, Translation) ->
  inputTemplate = '<input ng-model="translateVal.translatedPhrase"/>'
  tdTemplate    = '<span ng-bind="translateVal.translatedPhrase"></span>'


  getTemplate = (contentType) ->
    template = ''

    switch contentType
      when 'input'
        template = inputTemplate
      when 'td'
        template = tdTemplate

  updateTranslation = (_object) ->
    _object.statusId = 2
    Translation.upsert(_object)

  linker = (scope, element, attrs) ->
    _lock = false
    element.on 'click', (e) ->
      if !_lock
        element.html(getTemplate('input')).show()
        element.bind("keydown", (event) ->
          if(event.which==13)
            element.html(getTemplate('td')).show()
            scope.$apply ->
              $compile(element.contents())(scope)
            _lock = false
            updateTranslation(scope.translateVal)

            event.preventDefault()
        )
        scope.$apply ->
          $compile(element.contents())(scope)
      _lock = true

    return





  return {
    require: '^?stTable'
    template: '<span> {{ translateVal.translatedPhrase }} </span>'
    link: linker
    scope:
      translateVal:'='
  }



