module.exports =
  up: (queryInterface, Sequelize) ->
    queryInterface.createTable 'LanguageTranslations',
      language_id: type: Sequelize.INTEGER
      plural_form: type: Sequelize.INTEGER
  down: (queryInterface, Sequelize) ->
    queryInterface.dropTable 'LanguageTranslations'
