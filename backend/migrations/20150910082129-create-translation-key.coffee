module.exports =
  up: (queryInterface, Sequelize) ->
    queryInterface.createTable 'TranslationKeys',
      id:
        allowNull: false
        autoIncrement: true
        primaryKey: true
        type: Sequelize.INTEGER
      keyIndex: type: Sequelize.STRING
      isPlural: type: Sequelize.BOOLEAN
      projectId: type: Sequelize.INTEGER
      groupId: type: Sequelize.INTEGER
down: (queryInterface, Sequelize) ->
    queryInterface.dropTable 'TranslationKeys'
