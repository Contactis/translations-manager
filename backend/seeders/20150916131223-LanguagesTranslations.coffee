module.exports =
  up: (queryInterface, Sequelize) ->

    return queryInterface.bulkInsert 'LanguagesTranslations', [
      {
        languageId: 1
        pluralForm: 1
      }
      {
        languageId: 1
        pluralForm: 9
      }
      {
        languageId: 2
        pluralForm: 1
      }
      {
        languageId: 2
        pluralForm: 5
      }
      {
        languageId: 2
        pluralForm: 7
      }
      {
        languageId: 3
        pluralForm: 1
      }
      {
        languageId: 3
        pluralForm: 9
      }
      {
        languageId: 4
        pluralForm: 1
      }
      {
        languageId: 4
        pluralForm: 9
      }
      {
        languageId: 5
        pluralForm: 1
      }
      {
        languageId: 5
        pluralForm: 9
      }
    ], {}

  down: (queryInterface, Sequelize) ->

    return queryInterface.bulkDelete 'LanguagesTranslations', null, {}
