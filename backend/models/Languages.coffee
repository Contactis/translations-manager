module.exports = (sequelize, DataTypes) ->
  Languages = sequelize.define('Languages', {
    nameNative:       DataTypes.STRING
    nameEnglish:      DataTypes.STRING
    ietfCode:         DataTypes.STRING(10)
    description:      DataTypes.TEXT
  },
  {
    timestamps: false
  }
  , classMethods: associate: (models) ->
    # associations can be defined here
    return
  )

  return Languages
