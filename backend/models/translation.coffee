module.exports = (sequelize, DataTypes) ->
  Translation = sequelize.define('Translation', {
    translation: DataTypes.STRING
    language_id: DataTypes.INTEGER
    plural_form: DataTypes.INTEGER
    last_modified_by: DataTypes.INTEGER
    status: DataTypes.INTEGER
    note: DataTypes.TEXT
  }, classMethods: associate: (models) ->
    # associations can be defined here
    return
  )
  Translation
