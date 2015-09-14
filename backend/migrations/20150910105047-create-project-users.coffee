module.exports =
  up: (queryInterface, Sequelize) ->
    queryInterface.createTable 'ProjectUsers',
      projectId: type: Sequelize.INTEGER
      userId: type: Sequelize.INTEGER
  down: (queryInterface, Sequelize) ->
    queryInterface.dropTable 'ProjectUsers'
