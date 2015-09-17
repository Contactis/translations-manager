module.exports =
  up: (queryInterface, Sequelize) ->
    queryInterface.createTable 'Groups',
      id:
        type:           Sequelize.INTEGER
        primaryKey:     true
        autoIncrement:  true
        allowNull:      false
      parentId:
        type:           Sequelize.INTEGER
      name:
        type:           Sequelize.STRING
      namespace:
        type:           Sequelize.STRING
        allowNull:      false
  down: (queryInterface, Sequelize) ->
    queryInterface.dropTable 'Groups'
