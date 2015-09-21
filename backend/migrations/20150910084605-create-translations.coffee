module.exports =
  up: (queryInterface, Sequelize) ->
    queryInterface.createTable 'Translations',
      id:
        type:           Sequelize.INTEGER.UNSIGNED
        autoIncrement:  true
        primaryKey:     true
        allowNull:      false
      translatedPhrase:
        type:           Sequelize.STRING(600)
        allowNull:      false
      languageId:
        type:           Sequelize.INTEGER.UNSIGNED
        allowNull:      false
        references:
          model:        "Languages"
          key:          "id"
      pluralForm:
        type:           Sequelize.INTEGER
      TranslationsKeyId:
        type:           Sequelize.INTEGER
        allowNull:      false
      lastModifiedBy:
        type:           Sequelize.INTEGER
        allowNull:      false
        references:
          model:        "Users"
          key:          "id"
      status:
        type:           Sequelize.INTEGER
        allowNull:      false
        references:
          model:        "TranslationsStatuses"
          key:          "id"
      description:
        type:           Sequelize.TEXT
      createdAt:
        type:           Sequelize.DATE
        allowNull:      false
      updatedAt:
        type:           Sequelize.DATE
        allowNull:      false
  down: (queryInterface, Sequelize) ->
    queryInterface.dropTable 'Translations'
