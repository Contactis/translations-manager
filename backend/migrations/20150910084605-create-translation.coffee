module.exports =
  up: (queryInterface, Sequelize) ->
    queryInterface.createTable 'Translations',
      id:
        allowNull: false
        autoIncrement: true
        primaryKey: true
        type: Sequelize.INTEGER
      translation: type: Sequelize.STRING
      language_id: type: Sequelize.INTEGER
      project_id: type: Sequelize.INTEGER
      group_id: type: Sequelize.INTEGER
      plural_form: type: Sequelize.INTEGER
      last_modified_by: type: Sequelize.INTEGER
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
