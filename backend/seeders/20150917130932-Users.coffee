'use strict'
module.exports =
  up: (queryInterface, Sequelize) ->
    queryInterface.bulkInsert 'Users', [
      {
        id:         1
        email:      'admin@admin.com'
        firstName:  'Sir Super'
        lastName:   'Admin'
        password:   'admin'
        createdAt:  new Date()
        updatedAt:  new Date()
      }
    ], {}
  down: (queryInterface, Sequelize) ->
    queryInterface.bulkDelete 'Users', null, {}
