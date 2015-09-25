require('coffee-script').register()

env = process.env.NODE_ENV or 'development'

GLOBAL.config   = require(__dirname + '/config/server.json')[env]
GLOBAL.dbConfig = require(__dirname + '/config/database.json')[env]

require './bootstrap/associations'
require './bootstrap/webServer'
