# require build config
config = require '../variables'

gulp    = require 'gulp'
uglify  = require 'gulp-uglify'
concat  = require 'gulp-concat'
gulpif  = require 'gulp-if'

_jsFiles = config.build.vendor_files.js
_appFiles = [
  config.prod.tmpBuildDir + '/**/*.js'
]
_jsFiles = _jsFiles.concat(_appFiles)


# @method       build-js-prod
# @type         gulp-task
# @description  Take all JS files concatenate and uglify it to one, single file
gulp.task 'build-js-prod', ->
  gulp.src _jsFiles
  .pipe(concat(config.prod.jsDeployFileName))
  .pipe(gulpif(config.arguments.uglify, uglify()))
  .pipe(gulp.dest(config.buildDir))
