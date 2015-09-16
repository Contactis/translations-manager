module.exports = (sequelize, DataTypes) ->
  LanguagesTranslations = sequelize.define('LanguagesTranslations', {
    languageId:   DataTypes.INTEGER # FK
    pluralForm:   DataTypes.INTEGER # FK
  },
  {
    timestamps:   false
  }, classMethods: associate: (models) ->
    # associations can be defined here
    return
  )
  LanguagesTranslations.removeAttribute 'id'

  return LanguagesTranslations
