module.exports =
  up: (queryInterface, Sequelize) ->
    queryInterface.createTable 'Groups',
      id:
        type:           Sequelize.INTEGER.UNSIGNED
        primaryKey:     true
        autoIncrement:  true
        allowNull:      false
      parentId:
        type:           Sequelize.INTEGER.UNSIGNED
      name:
        type:           Sequelize.STRING
      projectId:
        type:           Sequelize.INTEGER.UNSIGNED
        allowNull:      false
      namespace:
        type:           Sequelize.STRING
        allowNull:      false
  down: (queryInterface, Sequelize) ->
    queryInterface.dropTable 'Groups'
