# # Helper Service

# @module   translation.services.helper
angular.module 'translation.services.helper', []

# @package      HelperService
# @description  This module should has helper methods and variables used
#               between modules/services/directives/filters during development
#               process
.service 'HelperService', ->

  # @public
  # @method       _diffArrayObjects
  # @description  Removes the same values from bigger collection of the same
  #               model
  _diffArrayObjects = (modelOne, modelTwo, equalKey) ->
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
    diffArrayObjects:     _diffArrayObjects


  return api
