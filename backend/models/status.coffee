'use strict'

module.exports = (sequelize, DataTypes) ->
  Status = sequelize.define('Status', {
    name: DataTypes.STRING
    description: DataTypes.STRING
  },
  {
    timestamps:   false
  }, classMethods: associate: (models) ->
    # associations can be defined here
    return
  )
  Status
