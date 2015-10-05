bcrypt = require 'bcryptjs'
authorisation = require '../services/authorisationService'

module.exports = (sequelize, DataTypes) ->
  Users = sequelize.define('Users', {
    id:
      type:         DataTypes.INTEGER.UNSIGNED
      allowNull:      false
      primaryKey:     true
      autoIncrement:  true
    email:
      type:         DataTypes.STRING
      validate:
        isEmail:    true
      allowNull:    false
    password:
      type:         DataTypes.STRING
      allowNull:    false
    firstName:      DataTypes.STRING
    lastName:       DataTypes.STRING
    role:
      type:         DataTypes.STRING
      defaultValue: 'user'
      allowNull:    false
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

      role: ->
        return authorisation.userRoles[this.dataValues.role]

    setterMethods:
      password: (password) ->
        this.setDataValue 'password', bcrypt.hashSync(password, bcrypt.genSaltSync(10))

    classMethods:
      generateHash: (password) ->
        return bcrypt.hash(password, 10)

    instanceMethods:
      validPassword: (password) ->
        return bcrypt.compareSync(password, this.password)

  })

  return Users
