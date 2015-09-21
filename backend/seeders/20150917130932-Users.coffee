'use strict'
module.exports =
  up: (queryInterface, Sequelize) ->
    queryInterface.bulkInsert 'Users', [
      {
        id:         1
        email:      'admin@admin.com'
        firstName:  'Super'
        lastName:   'Admin'
        password:   'asdf'
        token:      'loveMustangGt500'
        createdAt:  new Date()
        updatedAt:  new Date()
      }
    ], {}
  down: (queryInterface, Sequelize) ->
    queryInterface.bulkDelete 'Users', null, {}
