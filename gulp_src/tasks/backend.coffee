# require build config
config      = require '../variables'
nodemon     = require 'gulp-nodemon'
gulp        = require 'gulp'
coffeeLint  = require 'gulp-coffeelint'
shell       = require 'gulp-shell'
nodeConfig  = require './../../backend/config/database.json'
runSequence = require 'run-sequence'

gulp.task 'start-backend',  ->
  gulp.src(config.build.backendDir + "/**/*.coffee")
  .pipe(coffeeLint())
  .pipe(coffeeLint.reporter())


gulp.task 'nodemon', ->
  nodemon
    verbose: false
    ignore: [
      "*.test.js"
      "frontend/*"
      "public/*"
      "gulp_src/*"
    ]
    execMap:
      js:   "node backend/app.js"
    ext: "js coffee"
    tasks: ['start-backend']


gulp.task 'db:renew', shell.task [
  "cd backend && rm -f #{nodeConfig['development']['host']} && sequelize db:migrate --coffee --config 'config/database.json' "
]

gulp.task 'db:seed', shell.task [
  "cd backend && sequelize db:seed --coffee --config 'config/database.json'"
]

gulp.task 'db:restore', ->
  runSequence 'db:renew', 'db:seed'
