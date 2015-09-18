module.exports = (sequelize, DataTypes) ->
  Projects = sequelize.define('Projects', {
    name:             DataTypes.STRING
    defaultLanguage:  DataTypes.INTEGER
    description:      DataTypes.TEXT

  }, classMethods: associate: (models) ->
    # associations can be defined here

    return
  )

  return Projects
