# # Helper Service

# @module   translation.services.helper
angular.module 'translation.services.helper', [
  'lodash'
]

# @package      HelperService
# @description  This module should has helper methods and variables used
#               between modules/services/directives/filters during development
#               process
.service 'HelperService', ($log) ->

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

      if not _exists
        _newArray.push(referenceValue)


    return _newArray


  # @public
  # @method       _partitionArraysByParameter
  # @param        {Array}   stash     usually bigger array; with more objects
  # @param        {Array}   needle    usually smaller array; with less objects
  # @param        {String}  equalKey  parameter key of object; It should be **unique**
  # @description  Take `needle` array and compare it with `stash` to find
  #               common and different objects
  # @returns      {Array}
  # @example
  #     array1=[
  #       {id: 1, name: "Albert Einstein"}
  #       {id: 2, name: "Thomas Edison"}
  #       {id: 3, name: "Leonardo Da Vinci"}
  #     ]
  #     array2=[
  #       {id: 3, name: "Leonardo Da Vinci"}
  #       {id: 4, name: "Pablo Picasso"}
  #     ]
  #     _partitionArraysByParameter(array1, array2, 'name')
  _partitionArrayByParameter = (stash, needle, equalKey) ->
    if !angular.isArray(stash) or !angular.isArray(needle)
      throw new Error('Both parameters `stash` and `needle` must be Arrays')
    if angular.isUndefined(equalKey)
      throw new Error('Parameter `equalKey` must be provided')

    _commonArray = []
    _diffArray = []

    _.forEach stash, (referenceValue) ->
      _exists = false
      _.forEach needle, (comparableValue) ->
        if referenceValue[equalKey] == comparableValue[equalKey]
          _commonArray.push referenceValue
          console.log "match", referenceValue[equalKey]
        else
          console.log "_commonArray", _commonArray.length
          console.log "equalKey", equalKey, "referenceValue[equalKey]", referenceValue[equalKey]
          if not _.some(_commonArray, {equalKey: referenceValue[equalKey]})
            _diffArray.push referenceValue
            console.log "NOT match", referenceValue[equalKey]

    return [_commonArray, _diffArray]


  _partitionGreaterArrayByParameter = (array1, array2, equalKey) ->
    if !angular.isArray(array1) or !angular.isArray(array2)
      throw new Error('Both parameters `array1` and `array2` must be Arrays')
    if angular.isUndefined(equalKey)
      throw new Error('Parameter `equalKey` must be provided')

    if array2.length > array1.length
      _tmp = angular.copy array1
      array1 = angular.copy array2
      array2 = angular.copy _tmp

    if array2.length == 0
      return [ [], angular.copy array1 ]

    return _partitionArrayByParameter(array1, array2, equalKey)




  return api =
    diffArrayObjects:              _diffArrayObjects
    partitionArrayByParameter:          _partitionArrayByParameter
    partitionGreaterArrayByParameter:   _partitionGreaterArrayByParameter

