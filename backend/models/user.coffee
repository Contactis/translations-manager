'use strict'

module.exports = (sequelize, DataTypes) ->
  User = sequelize.define('User', {
    first_name: DataTypes.STRING
    last_name: DataTypes.STRING
    password: DataTypes.STRING
    token: DataTypes.STRING
  }, classMethods: associate: (models) ->
    # associations can be defined here
    return
  )
  User
