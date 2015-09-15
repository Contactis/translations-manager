module.exports = (sequelize, DataTypes) ->
  ProjectUsers = sequelize.define('ProjectUsers', {
    projectId: DataTypes.INTEGER
    userId: DataTypes.INTEGER
  },
  {
    timestamps:   false
  }, classMethods: associate: (models) ->
    # associations can be defined here
    return
  )
  ProjectUsers.removeAttribute 'id'
  ProjectUsers
