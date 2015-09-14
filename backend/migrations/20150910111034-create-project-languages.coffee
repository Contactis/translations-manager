module.exports =
  up: (queryInterface, Sequelize) ->
    queryInterface.createTable 'ProjectLanguages',
      project_id:
        type: Sequelize.INTEGER
      language_id:
        type: Sequelize.INTEGER
  down: (queryInterface, Sequelize) ->
    queryInterface.dropTable 'ProjectLanguages'
