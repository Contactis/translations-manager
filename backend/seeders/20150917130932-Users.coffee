'use strict'
module.exports =
  up: (queryInterface, Sequelize) ->
    queryInterface.bulkInsert 'Users', [
      {
        email:      'admin@admin.com'
        firstName:  'Super'
        lastName:   'Admin'
        password:   'asdf'
        createdAt:  new Date()
        updatedAt:  new Date()
      }
    ], {}
  down: (queryInterface, Sequelize) ->
    queryInterface.bulkDelete 'Users', null, {}
