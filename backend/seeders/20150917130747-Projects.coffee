moment = require 'moment'

module.exports =
  up: (queryInterface, Sequelize) ->

    return queryInterface.bulkInsert('Projects', [
      {
        id:   1
        name: 'Sample project'
        defaultLanguage: 1
        description: 'The purpus of this project is to test the API'
        createdAt: moment().format()
        updatedAt: moment().format()
      }
    ], {})

  down: (queryInterface, Sequelize) ->

    return queryInterface.bulkDelete('Projects', null, {})
