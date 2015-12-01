angular.module 'translation.services.plural', [
  'lodash'
]

.service 'PluralService', (_) ->

  _plurals = [
    { id: 0, name: "zero" }
    { id: 1, name: "one" }
    { id: 2, name: "two" }
    { id: 5, name: "few" }
    { id: 7, name: "many" }
    { id: 9, name: "other" }
  ]


  # @public
  # @method       _getAllPlural
  # @getter
  # @description  Simple get array with all plural objects
  # @returns      {Array}
  _getAllPlurals = ->
    return angular.copy _plurals


  # @public
  # @method       _getPlural
  # @getter
  # @param        {String}  objectId
  # @description  Get plual object with given `id` from plural list.
  # @returns      {Object}
  _getPlural = (objectId) ->
    return _.where(_plurals, {id: parseInt(objectId)})[0]


  api =
    getPlural:      _getPlural
    getAllPlurals:  _getAllPlurals

  return api
