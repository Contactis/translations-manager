'use strict'

module.exports = (sequelize, DataTypes) ->
  LanguagePluralForms = sequelize.define('LanguagePluralForms', {
    language_id: DataTypes.INTEGER
    plural_form_id: DataTypes.INTEGER
  },
  {
    timestamps:   false
  }, classMethods: associate: (models) ->
    # associations can be defined here
    return
  )

  LanguagePluralForms.removeAttribute 'id'
  LanguagePluralForms
