moment = require 'moment'

# Info: Account extends User

users = [
  {
    email:        'admin@admin.com'
    firstName:    'Sir Super'
    lastName:     'Admin'
    password:     'admin'
    role:         'admin'
    lastUpdated:  moment().format()
  }
  {
    email:        'manager@manager.com'
    firstName:    'Sir Super'
    lastName:     'Manager'
    password:     'manager'
    role:         'user'
    lastUpdated:  moment().format()
  }
  {
    email:        'translator@translator.com'
    firstName:    'Sir Super'
    lastName:     'Translator'
    password:     'translator'
    role:         'user'
    lastUpdated:  moment().format()
  }
  {
    email:        'programmer@programmer.com'
    firstName:    'Sir Super'
    lastName:     'Programmer'
    password:     'programmer'
    role:         'user'
    lastUpdated:  moment().format()
  }
]

users.forEach (value, i) ->
  Account.seed value
