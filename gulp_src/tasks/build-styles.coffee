# require build config
config = require '../variables'

gulp    = require 'gulp'
sass    = require 'gulp-sass'
rename  = require 'gulp-rename'
concat  = require 'gulp-concat'
addSrc  = require 'gulp-add-src'
gulpif  = require 'gulp-if'

gulp.task 'build-styles', ->
  gulp.src([
    'src/sass/theme_beta/main.sass'
    'src/sass/theme_beta/edisonda/css/style.sass'
  ])
  .pipe(sass({
      indentedSyntax: true
    }).on('error', sass.logError))
  .pipe(addSrc(config.build.vendor_files.css))
  .pipe(concat(config.pkg.name + '-' + config.pkg.version + '.css'))
  .pipe(gulpif(config.arguments.production, gulp.dest(config.buildDir), gulp.dest(config.buildDir + '/assets')))