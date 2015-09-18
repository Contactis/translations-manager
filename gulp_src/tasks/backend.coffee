# require build config

_dbConfigFilePath = 'config/database.json'

config          = require '../variables'
nodemon         = require 'gulp-nodemon'
gulp            = require 'gulp'
coffeeLint      = require 'gulp-coffeelint'
shell           = require 'gulp-shell'
databaseConfig  = require './../../backend/' + _dbConfigFilePath
runSequence     = require 'run-sequence'

gulp.task 'lint-backend',  ->
  gulp.src(config.build.backendDir + "/**/*.coffee")
  .pipe(coffeeLint())
  .pipe(coffeeLint.reporter())


gulp.task 'nodemon', ->
  runSequence 'lint-backend'

  nodemon
    verbose: false
    ignore: [
      "*.test.js"
      "frontend/*"
      "public/*"
      "gulp_src/*"
    ]
    execMap:
      js: "node backend/app.js"
    ext: "js coffee"



gulp.task 'db:renew', shell.task [
  "cd backend &&
   rm -f #{databaseConfig['development']['host']} &&
   sequelize db:migrate --coffee --config #{_dbConfigFilePath}"
]

gulp.task 'db:seed', shell.task [
  "cd backend &&
   sequelize db:seed --coffee --config #{_dbConfigFilePath}"
]

gulp.task 'db:restore', ->
  runSequence 'db:renew', 'db:seed'
