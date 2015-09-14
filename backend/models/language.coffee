module.exports = (sequelize, DataTypes) ->
  Language = sequelize.define('Language', {
      nameNative: DataTypes.STRING
      nameEnglish: DataTypes.STRING
      codeIetf: DataTypes.STRING
      description: DataTypes.STRING
    },
    {
      timestamps: false
    }
    ,classMethods:
      associate: (models) ->
# associations can be defined here
        return
  )
  Language
