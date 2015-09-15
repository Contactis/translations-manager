module.exports =
  up: (queryInterface, Sequelize) ->
    queryInterface.createTable 'LanguageTranslations',
      languageId: type: Sequelize.INTEGER
      pluralForm: type: Sequelize.INTEGER
  down: (queryInterface, Sequelize) ->
    queryInterface.dropTable 'LanguageTranslations'
