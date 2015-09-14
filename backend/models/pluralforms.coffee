module.exports = (sequelize, DataTypes) ->
  PluralForms = sequelize.define('PluralForms', {
    name: DataTypes.STRING
    description: DataTypes.STRING
  },
  {
    timestamps:   false
  },  classMethods: associate: (models) ->
    # associations can be defined here
    return
  )
  PluralForms
