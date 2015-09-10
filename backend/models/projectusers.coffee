module.exports = (sequelize, DataTypes) ->
  ProjectUsers = sequelize.define('ProjectUsers', {
    project_id: DataTypes.INTEGER
    user_id: DataTypes.INTEGER
  },
  {
    timestamps:   false
  }, classMethods: associate: (models) ->
    # associations can be defined here
    return
  )
  ProjectUsers.removeAttribute 'id'
  ProjectUsers
