module.exports =
  up: (queryInterface, Sequelize) ->
    queryInterface.createTable 'Users',
      id:
        type:           Sequelize.INTEGER
        allowNull:      false
        primaryKey:     true
      email:
        type:           Sequelize.STRING
        allowNull:      false
      firstName:
        type:           Sequelize.STRING
      lastName:
        type:           Sequelize.STRING
      password:
        type:           Sequelize.STRING
        allowNull:      false
      token:
        type:           Sequelize.STRING
      createdAt:
        allowNull:      false
        type:           Sequelize.DATE
      updatedAt:
        allowNull:      false
        type:           Sequelize.DATE
  down: (queryInterface, Sequelize) ->
    queryInterface.dropTable 'Users'
