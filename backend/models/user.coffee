module.exports = (sequelize, DataTypes) ->
  User = sequelize.define('User', {
    firstName: DataTypes.STRING
    lastName: DataTypes.STRING
    password: DataTypes.STRING
    token: DataTypes.STRING
  }, classMethods: associate: (models) ->
    # associations can be defined here
    return
  )
  User
