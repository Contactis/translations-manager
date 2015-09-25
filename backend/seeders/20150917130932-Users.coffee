moment = require 'moment'

module.exports =
  up: (queryInterface, Sequelize) ->
    queryInterface.bulkInsert 'Users', [
      {
        id:         1
        email:      'admin@admin.com'
        firstName:  'Sir Super'
        lastName:   'Admin'
        password:   'admin'
        createdAt:  moment().format()
        updatedAt:  moment().format()
      }
      {
        id:         2
        email:      'manager@manager.com'
        firstName:  'Sir Super'
        lastName:   'Manager'
        password:   'manager'
        createdAt:  moment().format()
        updatedAt:  moment().format()
      }
      {
        id:         3
        email:      'translator@translator.com'
        firstName:  'Sir Super'
        lastName:   'Translator'
        password:   'translator'
        createdAt:  moment().format()
        updatedAt:  moment().format()
      }
      {
        id:         4
        email:      'programmer@programmer.com'
        firstName:  'Sir Super'
        lastName:   'Programmer'
        password:   'programmer'
        createdAt:  moment().format()
        updatedAt:  moment().format()
      }
    ], {}
  down: (queryInterface, Sequelize) ->
    queryInterface.bulkDelete 'Users', null, {}
