# require build config
config = require '../variables'

gulp    = require 'gulp'
uglify  = require 'gulp-uglify'
concat  = require 'gulp-concat'
gulpif  = require 'gulp-if'

_jsFiles = config.build.vendor_files.js
_appFiles = [
  config.prod.buildAnnotated + '/app/**/*.js'
  config.prod.buildAnnotated + '/common/**/*.js'
  config.prod.buildAnnotated + '/' + config.build.tpl_name
]
_jsFiles = _jsFiles.concat(_appFiles)
_jsConcatedFileName = config.pkg.name + '_' + config.pkg.version + '.js'


# @method       build-js
# @type         gulp-task
# @description  Take all JS files uglify
gulp.task 'build-js', ->
  gulp.src _jsFiles
  .pipe(concat(_jsConcatedFileName))
  .pipe(gulpif(config.arguments.uglify, uglify()))
  .pipe(gulp.dest(config.buildDir))
