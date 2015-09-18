module.exports = (sequelize, DataTypes) ->
  Groups = sequelize.define('Groups', {
    parentId:     DataTypes.INTEGER
    name:         DataTypes.STRING
    namespace:    DataTypes.STRING
    projectId:    DataTypes.INTEGER
  },
  {
    timestamps:   false
  }, classMethods: associate: (models) ->
    # associations can be defined here
    return
  )

  return Groups
