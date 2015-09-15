module.exports = (sequelize, DataTypes) ->
  TranslationKey = sequelize.define('TranslationKey', {
    keyIndex: DataTypes.STRING
    isPlural: DataTypes.BOOLEAN
    projectId: DataTypes.INTEGER
    groupId: DataTypes.INTEGER
  },
  {
    timestamps:   false
  }, classMethods: associate: (models) ->
    # associations can be defined here
    return
  )
  TranslationKey
