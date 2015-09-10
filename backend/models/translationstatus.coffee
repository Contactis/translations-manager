'use strict'

module.exports = (sequelize, DataTypes) ->
  TranslationStatus = sequelize.define('TranslationStatus', {
    name: DataTypes.STRING
    description: DataTypes.STRING
  },
  {
    timestamps:   false
  }, classMethods: associate: (models) ->
    # associations can be defined here
    return
  )
  TranslationStatus
