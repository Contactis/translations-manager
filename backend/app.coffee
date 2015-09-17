require('coffee-script').register()

env = process.env.NODE_ENV or 'development'

GLOBAL.config = require(__dirname + '/config/server.json')[env]

require './bootstrap/associations'
require './bootstrap/webServer'