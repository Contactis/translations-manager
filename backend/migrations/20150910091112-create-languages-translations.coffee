module.exports =
  up: (queryInterface, Sequelize) ->
    queryInterface.createTable 'LanguagesTranslations',
      languageId:
        type:           Sequelize.INTEGER
        allowNull:      false
        references:
          model:        "Languages"
          key:          "id"
      pluralForm:
        type:           Sequelize.INTEGER
        allowNull:      false
        references:
          model:        "Translations"
          key:          "pluralForm"
  down: (queryInterface, Sequelize) ->
    queryInterface.dropTable 'LanguagesTranslations'
