angular.module 'translation.services.helper', []
.service 'HelperService', ->


  # @description Removes the same values from bigger collection of the same model
  diffArrayObjects = (modelOne, modelTwo, equalKey) ->
    if !angular.isArray(modelOne) or !angular.isArray(modelTwo)
      throw Error('Both parameters must be arrays')

    if modelTwo.length > modelOne.length
      _tmp = angular.copy modelOne
      modelOne = angular.copy modelTwo
      modelTwo = angular.copy _tmp

    if modelTwo.length == 0
      return modelOne

    _newArray = []

    angular.forEach modelOne, (referenceValue) ->
      _exists = false
      angular.forEach modelTwo, (comparableValue) ->
        _exists = referenceValue[equalKey] == comparableValue[equalKey]

      if !_exists
        _newArray.push(referenceValue)

    return _newArray


  api =
    diffArrayObjects: diffArrayObjects


  return api
