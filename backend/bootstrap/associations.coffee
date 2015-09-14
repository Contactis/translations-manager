orm = require '../models/index'
GLOBAL.orm = orm


orm.Status.belongsTo orm.Translation
orm.Translation.hasMany orm.Status