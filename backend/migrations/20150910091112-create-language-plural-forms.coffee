'use strict'
module.exports =
  up: (queryInterface, Sequelize) ->
    queryInterface.createTable 'LanguagePluralForms',
      language_id: type: Sequelize.INTEGER
      plural_form_id: type: Sequelize.INTEGER
  down: (queryInterface, Sequelize) ->
    queryInterface.dropTable 'LanguagePluralForms'
