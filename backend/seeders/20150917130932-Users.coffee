moment = require 'moment'

module.exports =
  up: (queryInterface, Sequelize) ->
    queryInterface.bulkInsert 'Users', [
      {
        id:         1
        email:      'admin@admin.com'
        firstName:  'Sir Super'
        lastName:   'Admin'
        password:   '$2a$10$3BtINIOoOvhLMBpC9Qpg3.9p0KDdwsr455YaM7vqKskwASU3rsL5u'
        role:       'admin'
        createdAt:  moment().format()
        updatedAt:  moment().format()
      }
      {
        id:         2
        email:      'manager@manager.com'
        firstName:  'Sir Super'
        lastName:   'Manager'
        password:   '$2a$10$VBWh22zGYb9Vn3TO/0PdeuTVQOM0IvE3ZkEtkBRedodunpQdLT3Yu'
        role:       'user'
        createdAt:  moment().format()
        updatedAt:  moment().format()
      }
      {
        id:         3
        email:      'translator@translator.com'
        firstName:  'Sir Super'
        lastName:   'Translator'
        password:   '$2a$10$dNztpl99C8mZSxztSaJQhuiBU.5aZvsE5LvjzfbTCit3m2GLocJdS'
        role:       'user'
        createdAt:  moment().format()
        updatedAt:  moment().format()
      }
      {
        id:         4
        email:      'programmer@programmer.com'
        firstName:  'Sir Super'
        lastName:   'Programmer'
        password:   '$2a$10$aNTw9ic4hs1cRR8eBpnum.AoyUqmfQLyxBK0fhE8Fgxzjvlryq9a6'
        role:       'user'
        createdAt:  moment().format()
        updatedAt:  moment().format()
      }
    ], {}
  down: (queryInterface, Sequelize) ->
    queryInterface.bulkDelete 'Users', null, {}
