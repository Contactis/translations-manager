module.exports = (sequelize, DataTypes) ->
  Translation = sequelize.define('Translation', {
    translation: DataTypes.STRING
    languageId: DataTypes.INTEGER
    pluralForm: DataTypes.INTEGER
    lastModifiedBy: DataTypes.INTEGER
    status: DataTypes.INTEGER
    note: DataTypes.TEXT
  }, classMethods: associate: (models) ->
    # associations can be defined here
    return
  )
  Translation
