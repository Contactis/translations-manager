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
        role:       'admin'
        createdAt:  moment().format()
        updatedAt:  moment().format()
      }
      {
        id:         2
        email:      'manager@manager.com'
        firstName:  'Sir Super'
        lastName:   'Manager'
        password:   'manager'
        role:       'user'
        createdAt:  moment().format()
        updatedAt:  moment().format()
      }
      {
        id:         3
        email:      'translator@translator.com'
        firstName:  'Sir Super'
        lastName:   'Translator'
        password:   'translator'
        role:       'user'
        createdAt:  moment().format()
        updatedAt:  moment().format()
      }
      {
        id:         4
        email:      'programmer@programmer.com'
        firstName:  'Sir Super'
        lastName:   'Programmer'
        password:   'programmer'
        role:       'user'
        createdAt:  moment().format()
        updatedAt:  moment().format()
      }
    ], {}
  down: (queryInterface, Sequelize) ->
    queryInterface.bulkDelete 'Users', null, {}
