module.exports =
  up: (queryInterface, Sequelize) ->
    queryInterface.createTable 'TranslationKeys',
      id:
        allowNull: false
        autoIncrement: true
        primaryKey: true
        type: Sequelize.INTEGER
      key_index: type: Sequelize.STRING
      is_plural: type: Sequelize.BOOLEAN
  down: (queryInterface, Sequelize) ->
    queryInterface.dropTable 'TranslationKeys'
