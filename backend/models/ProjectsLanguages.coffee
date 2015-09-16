module.exports = (sequelize, DataTypes) ->
  ProjectsLanguages = sequelize.define('ProjectsLanguages', {
    projectId:    DataTypes.INTEGER # FK
    languageId:   DataTypes.INTEGER # FK
  },
  {
    timestamps:   false
  }, classMethods: associate: (models) ->
    # associations can be defined here
    return
  )

  ProjectsLanguages.removeAttribute 'id'

  return ProjectsLanguages
