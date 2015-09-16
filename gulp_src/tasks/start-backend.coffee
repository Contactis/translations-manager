# require build config
config      = require '../variables'
nodemon     = require 'gulp-nodemon'
gulp        = require 'gulp'
coffeeLint  = require 'gulp-coffeelint'


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

