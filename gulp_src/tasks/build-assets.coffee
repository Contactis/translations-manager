# require build config
config = require '../variables'

gulp    = require 'gulp'
copy    = require 'gulp-copy'
gulpif  = require 'gulp-if'

assets = config.build.app_files.assets
assets = assets.concat config.build.vendor_files.assets

gulp.task 'copy-assets', ->
  gulp.src(assets)
  .pipe(gulp.dest(config.buildDir + '/assets'))

gulp.task 'copy-fonts', ->
  gulp.src('src/sass/' + config.build.project_theme_name + '/edisonda/css/fonts/**')
  .pipe(gulp.dest(config.buildDir + '/assets/fonts'))

gulp.task 'copy-files', ->
  gulp.src('src/sass/' + config.build.project_theme_name + '/edisonda/files/**')
  .pipe(gulp.dest(config.buildDir + '/assets/files/'))

gulp.task 'copy-images', ->
  gulp.src('src/sass/' + config.build.project_theme_name + '/edisonda/img/**')
  .pipe(gulp.dest(config.buildDir + '/assets/img/'))

gulp.task 'vendor-js', ->
  gulp.src(config.build.vendor_files.js)
  .pipe(gulpif(!config.arguments.production, copy(config.buildDir)))

gulp.task 'build-assets', [
  'copy-assets'
  'copy-angular-i18'
  'copy-fonts'
  'copy-edisonda-files'
  'copy-edisonda-images'
  'vendor-js'
]
