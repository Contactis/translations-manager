module.exports = (sequelize, DataTypes) ->
  LanguagePluralForms = sequelize.define('LanguageTranslations', {
    language_id: DataTypes.INTEGER
    plural_form: DataTypes.INTEGER
  },
  {
    timestamps:   false
  }, classMethods: associate: (models) ->
    # associations can be defined here
    return
  )

  LanguagePluralForms.removeAttribute 'id'
  LanguagePluralForms
