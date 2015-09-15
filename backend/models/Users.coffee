module.exports = (sequelize, DataTypes) ->
  Users = sequelize.define('Users', {
    email:
      type:       DataTypes.STRING
      validate:
        isEmail: true
      allowNull: false
    firstName:    DataTypes.STRING
    lastName:     DataTypes.STRING
    password:
      type:       DataTypes.STRING
      validate:
        notNull: true
  }, classMethods: associate: (models) ->
    # associations can be defined here
    return
  )

  return Users
