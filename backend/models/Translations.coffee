module.exports = (sequelize, DataTypes) ->
  Translations = sequelize.define('Translations', {
    translatedPhrase: DataTypes.STRING(600)
    pluralForm:       DataTypes.INTEGER # Types of plural forms are stored in bootstrap/pluralForms.coffee
    description:      DataTypes.TEXT
    translationsKeyId: DataTypes.INTEGER # FK
    languageId:       DataTypes.INTEGER # FK
    status:           DataTypes.INTEGER # FK
    lastModifiedBy:   DataTypes.INTEGER # FK
  }, classMethods: associate: (models) ->
    # associations can be defined here
    return
  )

  return Translations
