# require build config
config = require '../variables'

gulp    = require 'gulp'
uglify  = require 'gulp-uglify'
concat  = require 'gulp-concat'
gulpif  = require 'gulp-if'

jsFiles = config.build.vendor_files.js

appFiles = [
  config.buildDir + '/app/**/*.js'
  config.buildDir + '/common/**/*.js'
  config.buildDir + '/' + config.build.tpl_name
]

jsFiles = jsFiles.concat appFiles

gulp.task 'build-js', ->
  gulp.src jsFiles
  .pipe(concat(config.pkg.name + '-' + config.pkg.version + '.js'))
  .pipe(gulp.dest(config.buildDir))



