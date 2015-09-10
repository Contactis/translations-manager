'use strict'
module.exports =
  up: (queryInterface, Sequelize) ->
    queryInterface.createTable 'Languages',
      id:
        allowNull: false
        autoIncrement: true
        primaryKey: true
        type: Sequelize.INTEGER
      name_native: type: Sequelize.STRING
      name_english: type: Sequelize.STRING
      code_ietf: type: Sequelize.STRING
      description: type: Sequelize.STRING
  down: (queryInterface, Sequelize) ->
    queryInterface.dropTable 'Languages'
