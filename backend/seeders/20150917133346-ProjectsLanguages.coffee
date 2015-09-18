'use strict'
module.exports =
  up: (queryInterface, Sequelize) ->

    return queryInterface.bulkInsert('ProjectsLanguages', [
      {
        projectId: 1
        languageId: 1
      }
      {
        projectId: 1
        languageId: 2
      }
    ], {})

  down: (queryInterface, Sequelize) ->

    return queryInterface.bulkDelete('ProjectsLanguages', null, {})
