module.exports =
  up: (queryInterface, Sequelize) ->
    queryInterface.createTable 'ProjectsUsers',
      projectId:
        type:           Sequelize.INTEGER.UNSIGNED
        allowNull:      false
        references:
          model:        "Projects"
          key:          "id"
      userId:
        type:           Sequelize.INTEGER.UNSIGNED
        allowNull:      false
        references:
          model:        "Users"
          key:          "id"
  down: (queryInterface, Sequelize) ->
    queryInterface.dropTable 'ProjectsUsers'
