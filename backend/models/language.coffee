'use strict'

module.exports = (sequelize, DataTypes) ->
  Language = sequelize.define('Language', {
      name_native: DataTypes.STRING
      name_english: DataTypes.STRING
      code_ietf: DataTypes.STRING
      description: DataTypes.STRING
    },
    {
      timestamps: false
    }, classMethods:
    associate: (models) ->
# associations can be defined here
      return
  )
  Language
