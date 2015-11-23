# require build config
config = require '../variables'

gulp      = require 'gulp'
copy      = require 'gulp-copy'
gulpif    = require 'gulp-if'
file      = require 'gulp-file'
loopback  = require 'gulp-loopback-sdk-angular'
rename    = require 'gulp-rename'


#load common modules
permissionsConfig = require '../../common/permissionsConfig'

_assets = config.build.app_files.assets
_assets = _assets.concat config.build.vendor_files.assets


# @method       loopback-models
# @type         gulp-task
# @description  This task includes loopback models into dest folder, but
#               destination folder depends if it production build or not (dev)
gulp.task 'loopback-models', ->
  gulp.src('./server/server.js')
  .pipe(loopback())
  .pipe(rename('loopbackModelsService.js'))
  .pipe(gulpif(config.arguments.production, gulp.dest(config.prod.tmpBuildDir), gulp.dest('./public/common/services/loopbackModels')))


# @method       copy-assets
# @type         gulp-task
# @description  Copy assets files to `buildDir` (for both DEV and PROD)
gulp.task 'copy-assets', ->
  gulp.src(_assets)
  .pipe(gulp.dest(config.buildDir + '/assets'))


# @method       copy-fonts
# @type         gulp-task
# @description  Copy fonts to `assets/fonts` into `buildDir` directory
gulp.task 'copy-fonts', ->
  gulp.src(config.build.app_files.fonts)
  .pipe(gulp.dest(config.buildDir + '/assets/fonts'))


# @method       copy-vendor-angular-i18n
# @type         gulp-task
# @description  Copy internationalization files for angular locale to project
#               assets
gulp.task 'copy-vendor-angular-i18n', ->
  gulp.src(config.build.vendor_files.angular_i18n_locales)
  .pipe(gulp.dest(config.buildDir + '/assets/angular-i18n/'))


# @method       copy-files
# @type         gulp-task
# @description  Copy all files that are **not** *images* neither *CSS* files
#               (ex.: like PDFs) to `assets/files`
gulp.task 'copy-files', ->
  gulp.src(config.build.app_files.other_files)
  .pipe(gulp.dest(config.buildDir + '/assets/files/'))


# @method       copy-images
# @type         gulp-task
# @description  Copy all images related with project to assets directory
gulp.task 'copy-images', ->
  gulp.src(config.build.app_files.images)
  .pipe(gulp.dest(config.buildDir + '/assets/img/'))


# @method       vendor-js
# @type         gulp-task
# @description  Copy vendor files to `buildDir` only for DEVELOPMENT.
gulp.task 'vendor-js', ->
  gulp.src(config.build.vendor_files.js)
  .pipe(gulpif(!config.arguments.production, copy(config.buildDir)))


# @method       source-maps
# @type         gulp-task
# @description  Build source maps for the project
gulp.task 'source-maps', (cb) ->
  _vendorFiles = config.build.vendor_files.sourceMaps
  _keys = Object.keys _vendorFiles

  if _keys.length > 0
    _keys.forEach (val, i) ->
      gulp.src(_vendorFiles[val].source)
      .pipe(gulp.dest(_vendorFiles[val].destination))
  cb()


# @method       permissions-config
# @type         gulp-task
# @description  Copy permissions configuration and save it as String
gulp.task 'permissions-config', ->
  _string = "common.permissionConfig = #{JSON.stringify permissionsConfig};"
  return file('frontend/vendors_offline/permissionConfig.js', _string, {src: true}).pipe(gulp.dest('./'))


# @method       build-assets
# @type         gulp-task
# @description  Main task of building all assests for the project
gulp.task 'build-assets', [
  'permissions-config'
  'copy-assets'
  'copy-fonts'
  'copy-files'
  'copy-images'
  'copy-vendor-angular-i18n'
  'vendor-js'
  'source-maps'
]
