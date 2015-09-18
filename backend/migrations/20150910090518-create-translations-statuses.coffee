module.exports =
  up: (queryInterface, Sequelize) ->
    queryInterface.createTable 'TranslationStatuses',
      id:
        type:           Sequelize.INTEGER.UNSIGNED
        autoIncrement:  true
        primaryKey:     true
        allowNull:      false
      name:
        type:           Sequelize.STRING
        allowNull:      false
      description:
        type:           Sequelize.TEXT
  down: (queryInterface, Sequelize) ->
    queryInterface.dropTable 'TranslationStatuses'
