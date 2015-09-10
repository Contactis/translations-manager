'use strict'
module.exports =
  up: (queryInterface, Sequelize) ->
    queryInterface.createTable 'Groups',
      id:
        allowNull: false
        autoIncrement: true
        primaryKey: true
        type: Sequelize.INTEGER
      parent_id: type: Sequelize.INTEGER
      name: type: Sequelize.STRING
      namespace: type: Sequelize.STRING
  down: (queryInterface, Sequelize) ->
    queryInterface.dropTable 'Groups'
