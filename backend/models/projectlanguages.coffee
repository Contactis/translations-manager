module.exports = (sequelize, DataTypes) ->
  ProjectLanguages = sequelize.define('ProjectLanguages', {
    projectId: DataTypes.INTEGER
    languageId: DataTypes.INTEGER
  },
  {
    timestamps:   false
  }, classMethods: associate: (models) ->
    # associations can be defined here
    return
  )
  ProjectLanguages.removeAttribute 'id'
  ProjectLanguages
