module.exports = (sequelize, DataTypes) ->
  LanguageTranslations = sequelize.define('LanguageTranslations', {
    languageId: DataTypes.INTEGER
    pluralForm: DataTypes.INTEGER
  },
  {
    timestamps:   false
  }, classMethods: associate: (models) ->
    # associations can be defined here
    return
  )

  LanguageTranslations.removeAttribute 'id'
  LanguageTranslations
