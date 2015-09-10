'use strict'

module.exports = (sequelize, DataTypes) ->
  Project = sequelize.define('Project', {
    name: DataTypes.STRING
    description: DataTypes.STRING
    default_language: DataTypes.INTEGER
  }, classMethods: associate: (models) ->
    # associations can be defined here
    return
  )
  Project
