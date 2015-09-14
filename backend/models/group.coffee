module.exports = (sequelize, DataTypes) ->
  Group = sequelize.define('Group', {
    parentId: DataTypes.INTEGER
    name: DataTypes.STRING
    namespace: DataTypes.STRING
  },
  {
    timestamps:   false
  }, classMethods: associate: (models) ->
    # associations can be defined here
    return
  )
  Group
