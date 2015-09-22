module.exports =
  up: (queryInterface, Sequelize) ->
    queryInterface.createTable 'Sessions',
      id:
        type:           Sequelize.INTEGER.UNSIGNED
        primaryKey:     true
        autoIncrement:  true
        allowNull:      false
      userId:
        type:           Sequelize.INTEGER.UNSIGNED
        allowNull:      false
        references:
          model:        "Users"
          key:          "id"
      token:
        type:           Sequelize.STRING(10)
      expiryAt:
        type:           Sequelize.DATE
        allowNull:      false
      createdAt:
        type:           Sequelize.DATE
        allowNull:      false
      updatedAt:
        type:           Sequelize.DATE
        allowNull:      false
  down: (queryInterface, Sequelize) ->
    queryInterface.dropTable 'Sessions'
