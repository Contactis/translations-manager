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
      {
        id:         2
        email:      'manager@manager.com'
        firstName:  'Sir Super'
        lastName:   'Manager'
        password:   'manager'
        createdAt:  new Date()
        updatedAt:  new Date()
      }
      {
        id:         3
        email:      'translator@translator.com'
        firstName:  'Sir Super'
        lastName:   'Translator'
        password:   'translator'
        createdAt:  new Date()
        updatedAt:  new Date()
      }
      {
        id:         4
        email:      'programmer@programmer.com'
        firstName:  'Sir Super'
        lastName:   'Programmer'
        password:   'programmer'
        createdAt:  new Date()
        updatedAt:  new Date()
      }
    ], {}
  down: (queryInterface, Sequelize) ->
    queryInterface.bulkDelete 'Users', null, {}
