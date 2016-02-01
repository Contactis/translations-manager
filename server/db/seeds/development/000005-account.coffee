moment = require 'moment'

# Info: Account extends User

accounts = [
  {
    email:              'admin@admin.com'
    firstName:          'Sir Super'
    username:           'Sir Admin'
    lastName:           'Admin'
    password:           'admin'
    role:               'admin'
    interfaceLanguage:  'en-us'
    emailVerified:      true
    lastUpdated:        moment().format()
  }
  {
    email:              'manager@manager.com'
    firstName:          'Sir Super'
    username:           'Sir Manager'
    lastName:           'Manager'
    password:           'manager'
    role:               'manager'
    interfaceLanguage:  'en-us'
    emailVerified:      true
    lastUpdated:        moment().format()
  }
  {
    email:              'translator@translator.com'
    firstName:          'Sir Super'
    username:           'Sir Translator'
    lastName:           'Translator'
    password:           'translator'
    role:               'translator'
    interfaceLanguage:  'en-us'
    emailVerified:      true
    lastUpdated:        moment().format()
  }
  {
    email:              'programmer@programmer.com'
    firstName:          'Sir Super'
    username:           'Sir Programmer'
    lastName:           'Programmer'
    password:           'programmer'
    role:               'programmer'
    interfaceLanguage:  'en-us'
    emailVerified:      true
    lastUpdated:        moment().format()
  }
]

accounts.forEach (value, i) ->
  Account.seed value


