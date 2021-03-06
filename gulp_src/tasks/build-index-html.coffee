# require build config
config = require '../variables'

gulp        = require 'gulp'
inject      = require 'gulp-inject'
series      = require 'stream-series'
htmlmin     = require 'gulp-htmlmin'


# @method       build-index-html
# @type         gulp-task
# @description  Build tempalteCache from bakin' HTML templates from files with
#               `.tpl.html` extension.
gulp.task 'build-index-html', ->
  appSrc = gulp.src [
    config.buildDir + '/app/**/*.js'
    config.buildDir + '/common/**/*.js'
    config.buildDir + '/' + config.build.tpl_name
  ],
    read: false

  vendorSrc = gulp.src config.build.vendor_files.js,
    read: false

  styles = gulp.src config.buildDir + '/assets/*.css',
    read: false

  gulp.src 'frontend/index.html'
  .pipe inject( series(vendorSrc, appSrc, styles),
    ignorePath: config.buildDir)
  .pipe gulp.dest config.buildDir


# @method       build-index-html-prod
# @type         gulp-task
# @description  Put concatenated, minified and uglified files of JS and CSS
#               into `index.html`
gulp.task 'build-index-html-prod', ->
  appSrc = gulp.src [
    config.buildDir + '/*.js'
    config.buildDir + '/*.css'
  ],
    read: false

  gulp.src 'frontend/index.html'
  .pipe inject(appSrc,
    ignorePath: config.buildDir)
  .pipe htmlmin
    collapseWhitespace:   true
    removeTagWhitespace:  true
  .pipe gulp.dest config.buildDir
