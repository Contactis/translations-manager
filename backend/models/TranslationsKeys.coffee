module.exports = (sequelize, DataTypes) ->
  TranslationsKeys = sequelize.define('TranslationsKeys', {
    keyString:     DataTypes.STRING(600)
    isPlural:     DataTypes.BOOLEAN
    projectId:    DataTypes.INTEGER
    groupId:      DataTypes.INTEGER
  },
  {
    timestamps:   false
  }, classMethods: associate: (models) ->
    # associations can be defined here
    return
  )

  return TranslationsKeys
