module.exports =
  up: (queryInterface, Sequelize) ->
    queryInterface.createTable 'ProjectLanguages',
      projectId: type: Sequelize.INTEGER
      languageId: type: Sequelize.INTEGER
  down: (queryInterface, Sequelize) ->
    queryInterface.dropTable 'ProjectLanguages'
