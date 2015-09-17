sequelize     = null
Sequelize     = require('sequelize')
fs            = require('fs')
path          = require('path')

basename      = path.basename(module.filename)
env           = process.env.NODE_ENV or 'development'
config        = require(__dirname + '/../config/database.json')[env]
db            = {}


databasePath = path.resolve __dirname + '/../' + config.host

config.host = databasePath
config.storage = databasePath

sequelize = new Sequelize(config.database, config.username, config.password, config)

fs.readdirSync(__dirname).filter((file) ->
  file.indexOf('.') != 0 and file != basename
).forEach (file) ->
  if file.slice(-7) != '.coffee'
    return
  model = sequelize['import'](path.join(__dirname, file))
  db[model.name] = model
  return

Object.keys(db).forEach (modelName) ->
  if db[modelName].associate
    db[modelName].associate db
  return

db.sequelize = sequelize
db.Sequelize = Sequelize

module.exports = db
