module.exports =
  up: (queryInterface, Sequelize) ->
    queryInterface.createTable 'Users',
      email:
        type:           Sequelize.STRING
        allowNull:      false
        primaryKey:     true
      firstName:
        type:           Sequelize.STRING
      lastName:
        type:           Sequelize.STRING
      password:
        type:           Sequelize.STRING
      createdAt:
        allowNull:      false
        type:           Sequelize.DATE
      updatedAt:
        allowNull:      false
        type:           Sequelize.DATE
  down: (queryInterface, Sequelize) ->
    queryInterface.dropTable 'Users'
