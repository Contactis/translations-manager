'use strict'
module.exports =
  up: (queryInterface, Sequelize) ->

    return queryInterface.bulkInsert('Groups', [
      {
        id: 1
        parentId: null
        namespace: "Home"
        projectId: 1
      }
      {
        id: 2
        parentId: 1
        namespace: "Login"
        projectId: 1
      }
      {
        id: 3
        parentId: 1
        namespace: "Register"
        projectId: 1
      }
      {
        id: 4
        parentId: 2
        namespace: "Forgot password"
        projectId: 1
      }
      {
        id: 5
        parentId: 2
        namespace: "Token reset"
        projectId: 1
      }
    ], {})

  down: (queryInterface, Sequelize) ->

    return queryInterface.bulkDelete('Groups', null, {})