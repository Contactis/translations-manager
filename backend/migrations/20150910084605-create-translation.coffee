module.exports =
  up: (queryInterface, Sequelize) ->
    queryInterface.createTable 'Translations',
      id:
        allowNull: false
        autoIncrement: true
        primaryKey: true
        type: Sequelize.INTEGER
      translation: type: Sequelize.STRING
      languageId: type: Sequelize.INTEGER
      pluralForm: type: Sequelize.INTEGER
      lastModifiedBy: type: Sequelize.INTEGER
      status: type: Sequelize.INTEGER
      note: type: Sequelize.TEXT
      createdAt:
        allowNull: false
        type: Sequelize.DATE
      updatedAt:
        allowNull: false
        type: Sequelize.DATE
  down: (queryInterface, Sequelize) ->
    queryInterface.dropTable 'Translations'
