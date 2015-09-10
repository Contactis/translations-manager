module.exports =
  up: (queryInterface, Sequelize) ->
    queryInterface.createTable 'Users',
      id:
        allowNull: false
        autoIncrement: true
        primaryKey: true
        type: Sequelize.INTEGER
      first_name: type: Sequelize.STRING
      last_name: type: Sequelize.STRING
      password: type: Sequelize.STRING
      token: type: Sequelize.STRING
      createdAt:
        allowNull: false
        type: Sequelize.DATE
      updatedAt:
        allowNull: false
        type: Sequelize.DATE
  down: (queryInterface, Sequelize) ->
    queryInterface.dropTable 'Users'
