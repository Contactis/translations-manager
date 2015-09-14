module.exports = (sequelize, DataTypes) ->
  ProjectLanguages = sequelize.define('ProjectLanguages', {
    project_id: DataTypes.INTEGER
    language_id: DataTypes.INTEGER
  },
  {
    timestamps:   false
  }, classMethods: associate: (models) ->
    # associations can be defined here
    return
  )
  ProjectLanguages.removeAttribute 'id'
  ProjectLanguages
