'use strict'

module.exports = (sequelize, DataTypes) ->
  TranslationKey = sequelize.define('TranslationKey', {
    key_index: DataTypes.STRING
    is_plural: DataTypes.BOOLEAN
  },
  {
    timestamps:   false
  }, classMethods: associate: (models) ->
    # associations can be defined here
    return
  )
  TranslationKey
