env = process.env.NODE_ENV or 'development'
GLOBAL.config = require(__dirname + '/config/config.json')[env]


require './bootstrap/associations'
require './bootstrap/webServer'


require './routes/angular'