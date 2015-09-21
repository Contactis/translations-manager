bcrypt = require 'bcryptjs'

module.exports = (sequelize, DataTypes) ->
  Users = sequelize.define('Users', {
    id:
      type:         DataTypes.INTEGER
      allowNull:    false
      primaryKey:   true
    email:
      type:         DataTypes.STRING
      validate:
        isEmail: true
        notNull: true
      allowNull:    false
    password:
      type:         DataTypes.STRING
      validate:
        notNull: true
      allowNull:    false
    firstName:      DataTypes.STRING
    lastName:       DataTypes.STRING
    token:
      type:         DataTypes.STRING
  },
  {
    indexes: [
      {
        unique: true
        fields: ['email']
      }
    ]

    getterMethods:
      fullName: ->
        return this.firstName + ' ' + this.lastName

    classMethods:
      generateHash: (password) ->
        return bcrypt.hashSync(password, 10)

      validPassword: (password) ->
        return bcrypt.compareSync(password, this.password)
  })

  return Users
