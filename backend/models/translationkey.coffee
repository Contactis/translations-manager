module.exports = (sequelize, DataTypes) ->
  TranslationKey = sequelize.define('TranslationKey', {
    key_index: DataTypes.STRING
    is_plural: DataTypes.BOOLEAN
    project_id: DataTypes.INTEGER
    group_id: DataTypes.INTEGER
  },
  {
    timestamps:   false
  }, classMethods: associate: (models) ->
    # associations can be defined here
    return
  )
  TranslationKey
