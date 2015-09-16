module.exports =
  up: (queryInterface, Sequelize) ->

      return queryInterface.bulkInsert 'Languages', [
        {
          id:           1
          nameNative:   'English'
          nameEnglish:  'English'
          ietfCode:     'en'
          description:  ''
        }
        {
          id:           2
          nameNative:   'Polski'
          nameEnglish:  'Polish'
          ietfCode:     'pl'
          description:  ''
        }
        {
          id:           3
          nameNative:   'Deutsch'
          nameEnglish:  'German'
          ietfCode:     'de'
          description:  ''
        }
        {
          id:           4
          nameNative:   'Portuguese'
          nameEnglish:  'português'
          ietfCode:     'pt'
          description:  ''
        }
        {
          id:           5
          nameNative:   'Nederlands'
          nameEnglish:  'Dutch'
          ietfCode:     'nl'
          description:  ''
        }
      ], {}


  down: (queryInterface, Sequelize) ->

    return queryInterface.bulkDelete('Languages', null, {})
