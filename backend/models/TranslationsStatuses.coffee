module.exports = (sequelize, DataTypes) ->
  TranslationsStatuses = sequelize.define('TranslationsStatuses', {
    name:           DataTypes.STRING
    description:    DataTypes.TEXT
  },
  {
    timestamps:   false
  }
  , classMethods: associate: (models) ->
    # associations can be defined here
    return
  )

  return TranslationsStatuses
