# require build config
config = require '../variables'

plumber = require 'gulp-plumber'
gulp    = require 'gulp'
rimraf  = require 'gulp-rimraf'

gulp.task 'clean', ->
  gulp.src(config.buildDir, {read: false})
  .pipe(plumber())
  .pipe(rimraf({force: true}))

gulp.task 'clean-all', ->
  gulp.src(config.gulpDir, {read: false})
  .pipe(plumber())
  .pipe(rimraf({force: true}))

