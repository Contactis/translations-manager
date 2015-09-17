'use strict'
module.exports =
  up: (queryInterface, Sequelize) ->

    return queryInterface.bulkInsert('Groups', [
      {
        id: 1
        parentId: null
        namespace: "Home"
      }
      {
        id: 2
        parentId: 1
        namespace: "Login"
      }
      {
        id: 3
        parentId: 1
        namespace: "Register"
      }
      {
        id: 4
        parentId: 2
        namespace: "Forgot password"
      }
      {
        id: 5
        parentId: 2
        namespace: "Token reset"
      }
    ], {})

  down: (queryInterface, Sequelize) ->

    return queryInterface.bulkDelete('Groups', null, {})