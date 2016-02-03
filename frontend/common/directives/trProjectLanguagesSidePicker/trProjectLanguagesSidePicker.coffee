angular.module('translation.directive.trProjectLanguagesSidePicker', [
  'lbServices'
  'translation.services.helper'
  'lodash'
])

.directive 'trProjectLanguagesSidePicker', (HelperService) ->
  restrict:       'EA'
  replace:        true
  templateUrl:    'directives/trProjectLanguagesSidePicker/trProjectLanguagesSidePicker.tpl.html'
  scope:
    unselectedData:     '='
    unselectedTitle:    '@'
    selectedData:       '='
    selectedTitle:      '@'
    currentProject:     '='
    allLanguages:       '='
    choosenLanguages:   '='
    leftLanguages:      '='

  link: (scope, element, attrs, ctrl) ->

    # Saving state before changes
    scope.previousUnselectedData  = angular.copy(scope.unselectedData)
    scope.previousSelectedData    = angular.copy(scope.selectedData)


    # @private
    # @method       _moveObject
    # @returns      {None}
    # @description  Splice object of given index from `fromArray` to `toArray`.
    _moveObject = (fromArray, toArray, index) ->
      obj = fromArray.splice(index, 1)
      toArray.push obj[0]
      return


    _partitionLanguagesArray = () ->
      left      = []
      choosen   = []
      for i in scope.allLanguages
        bool = false # save the state if found during second loop
        for k in scope.selectedData
          if i.id is k.languageId and (not _.some(choosen, {id: k.languageId}))
            bool = true
        if bool then choosen.push i else left.push i
      return [ left, choosen ]


    # NOTE !!!
    # Need to evaluate ONLY ONCE to set available languages for selection
    # (_evaluateAvailableLanguage = () ->
    scope.leftLanguages     = _partitionLanguagesArray()[0]
    scope.choosenLanguages  = _partitionLanguagesArray()[1]
    # )(@)


    scope.isUnselectedListEmpty = () ->
      return !scope.leftLanguages.length


    scope.isSelectedListEmpty = () ->
      return !scope.choosenLanguages.length


    # @public
    # @method       scope.addToSelectedList
    scope.addToSelectedList = (languageId) ->
      console.log "languageId", languageId
      index = _.findIndex(scope.leftLanguages, (item) ->
        item.id is languageId)
      _moveObject(scope.leftLanguages, scope.choosenLanguages, index)
      return


    # @public
    # @method       scope.addToUnselectedList
    scope.addToUnselectedList = (languageId) ->
      console.log "languageId", languageId
      index = _.findIndex(scope.choosenLanguages, (item) ->
        item.id is languageId)
      _moveObject(scope.choosenLanguages, scope.leftLanguages, index)
      return

    return
