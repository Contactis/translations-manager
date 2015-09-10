'use strict'
module.exports =
  up: (queryInterface, Sequelize) ->
    queryInterface.createTable 'Statuses',
      id:
        allowNull: false
        autoIncrement: true
        primaryKey: true
        type: Sequelize.INTEGER
      name: type: Sequelize.STRING
      description: type: Sequelize.STRING
  down: (queryInterface, Sequelize) ->
    queryInterface.dropTable 'Statuses'
