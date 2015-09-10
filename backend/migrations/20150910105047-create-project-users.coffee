module.exports =
  up: (queryInterface, Sequelize) ->
    queryInterface.createTable 'ProjectUsers',
      project_id: type: Sequelize.INTEGER
      user_id: type: Sequelize.INTEGER
  down: (queryInterface, Sequelize) ->
    queryInterface.dropTable 'ProjectUsers'
