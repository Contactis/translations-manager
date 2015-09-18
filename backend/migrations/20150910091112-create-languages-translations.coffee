module.exports =
  up: (queryInterface, Sequelize) ->
    queryInterface.createTable 'LanguagesTranslations',
      languageId:
        type:           Sequelize.INTEGER.UNSIGNED
        allowNull:      false
        references:
          model:        "Languages"
          key:          "id"
      pluralForm:
        type:           Sequelize.INTEGER.UNSIGNED
        allowNull:      false
  down: (queryInterface, Sequelize) ->
    queryInterface.dropTable 'LanguagesTranslations'
