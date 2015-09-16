module.exports = (sequelize, DataTypes) ->
  ProjectsUsers = sequelize.define('ProjectsUsers', {
    # projectId:    DataTypes.INTEGER # FK
    # userId:       DataTypes.INTEGER # FK
  },
  {
    timestamps:   false
  }, classMethods: associate: (models) ->
    # associations can be defined here
    return
  )

  ProjectsUsers.removeAttribute 'id'

  return ProjectsUsers
