module.exports =
  up: (queryInterface, Sequelize) ->

    return queryInterface.bulkInsert('ProjectsUsers', [
      {
        userId: 1
        projectId: 1
      }
      {
        userId: 2
        projectId: 1
      }
      {
        userId: 4
        projectId: 1
      }
    ], {})


  down: (queryInterface, Sequelize) ->

    return queryInterface.bulkDelete('ProjectsUsers', null, {})
