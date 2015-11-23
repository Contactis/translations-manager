# require build config
config = require '../variables'

gulp      = require 'gulp'
sass      = require 'gulp-sass'
minifyCss = require 'gulp-minify-css'
uglifyCss = require 'gulp-uglifycss'
rename    = require 'gulp-rename'
concat    = require 'gulp-concat'
addSrc    = require 'gulp-add-src'
gulpif    = require 'gulp-if'


# @method       build-styles
# @type         gulp-task
# @description  Building CSS styles (for PRODUCTION and DEVELOPMENT)
gulp.task 'build-styles', ->
  gulp.src(config.build.app_files.sass)
  .pipe(sass({
      indentedSyntax: true
    }).on('error', sass.logError))
  .pipe addSrc config.build.vendor_files.css
  .pipe concat config.cssDeployFileName
  .pipe gulpif config.arguments.production, minifyCss()
  .pipe gulpif config.arguments.production, uglifyCss
    'max-line-len': 80
  .pipe(gulpif(config.arguments.production, gulp.dest(config.buildDir), gulp.dest(config.buildDir + '/assets')))
