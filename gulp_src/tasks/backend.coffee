# require build config

_dbConfigFilePath = 'config/database.json'

config          = require '../variables'
nodemon         = require 'gulp-nodemon'
gulp            = require 'gulp'
coffeeLint      = require 'gulp-coffeelint'
shell           = require 'gulp-shell'
databaseConfig  = require './../../backend/' + _dbConfigFilePath
runSequence     = require 'run-sequence'
argv            = require('yargs').argv

gulp.task 'lint-backend',  ->
  gulp.src(config.build.backendDir + "/**/*.coffee")
  .pipe(coffeeLint())
  .pipe(coffeeLint.reporter())


gulp.task 'nodemon', ->

  _jsExec = 'node .'

  if (typeof argv.aclDebug is not "undefined") or (argv.aclDebug is true)
    _jsExec = 'DEBUG=loopback:security:* slc run'


  nodemon
    verbose: false
    ignore: [
      "*.test.js"
      "frontend/*"
      "public/*"
      "gulp_src/*"
    ]
    execMap:
      js: _jsExec
    ext: "js coffee json"

gulp.task 'db:renew', shell.task [
  "rm -f translation_manager_db.sqlite && node ./ --kill --silent"
]

gulp.task 'db:seed', shell.task [
  "node ./ --seeds --silent"
]

gulp.task 'db:restore', ->
  runSequence 'db:renew', 'db:seed'
