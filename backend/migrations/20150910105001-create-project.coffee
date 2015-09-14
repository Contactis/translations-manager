module.exports =
  up: (queryInterface, Sequelize) ->
    queryInterface.createTable 'Projects',
      id:
        allowNull: false
        autoIncrement: true
        primaryKey: true
        type: Sequelize.INTEGER
      name: type: Sequelize.STRING
      description: type: Sequelize.STRING
      defaultLanguage: type: Sequelize.INTEGER
      createdAt:
        allowNull: false
        type: Sequelize.DATE
      updatedAt:
        allowNull: false
        type: Sequelize.DATE
  down: (queryInterface, Sequelize) ->
    queryInterface.dropTable 'Projects'
