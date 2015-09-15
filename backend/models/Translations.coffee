module.exports = (sequelize, DataTypes) ->
  Translations = sequelize.define('Translations', {
    translatedPhrase: DataTypes.STRING(600)
    pluralForms:      DataTypes.INTEGER # Types of plural forms are stored in bootstrap/pluralForms.coffee
    description:      DataTypes.TEXT

    translationKeyId: DataTypes.INTEGER # FK
    languageId:       DataTypes.INTEGER # FK
    statusId:         DataTypes.INTEGER # FK
    lastModifiedBy:   DataTypes.INTEGER # FK
  }, classMethods: associate: (models) ->
    # associations can be defined here
    return
  )

  return Translations
