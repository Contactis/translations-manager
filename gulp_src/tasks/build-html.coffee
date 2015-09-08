# require build config
config = require '../variables'

gulp      = require 'gulp'
inject    = require 'gulp-inject'
series    = require 'stream-series'
htmlmini  = require 'gulp-minify-html'

gulp.task 'build-html', ->

  appSrc = gulp.src [
    config.buildDir + '/app/**/*.js'
    config.buildDir + '/common/**/*.js'
    config.buildDir + '/sass/' + config.build.project_theme_name + '/edisonda/js/**/*.js'
    config.buildDir + '/' + config.build.tpl_name
  ],
    read: false

  vendorSrc = gulp.src config.build.vendor_files.js,
    read: false

  gitCommit = gulp.src(config.buildDir + '/assets/gitcommit.js')

  styles = gulp.src config.buildDir + '/assets/*.css',
    read: false

  gulp.src 'src/index.html'
  .pipe inject(series(vendorSrc, gitCommit, appSrc, styles),
    ignorePath: config.buildDir)
  .pipe gulp.dest config.buildDir


gulp.task 'build-html-prod', ->

  appSrc = gulp.src [
      config.buildDir + '/*.js'
      config.buildDir + '/*.css'
    ],
    read: false


  gulp.src 'src/index.html'
  .pipe inject(appSrc,
    ignorePath: config.buildDir)
  .pipe htmlmini
          conditionals: true
  .pipe gulp.dest config.buildDir