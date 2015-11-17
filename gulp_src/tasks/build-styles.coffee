# require build config
config = require '../variables'

gulp      = require 'gulp'
sass      = require 'gulp-sass'
minifyCss = require 'gulp-minify-css'
rename    = require 'gulp-rename'
concat    = require 'gulp-concat'
addSrc    = require 'gulp-add-src'
gulpif    = require 'gulp-if'

gulp.task 'build-styles', ->
  gulp.src(config.build.app_files.sass)
  .pipe(sass({
      indentedSyntax: true
    }).on('error', sass.logError))
  .pipe addSrc config.build.vendor_files.css
  .pipe concat config.cssDeployFileName
  .pipe gulpif(config.arguments.production, minifyCss())
  .pipe(gulpif(config.arguments.production, gulp.dest(config.buildDir), gulp.dest(config.buildDir + '/assets')))
