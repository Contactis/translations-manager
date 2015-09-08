# require build config
config = require '../variables'

gulp        = require 'gulp'
addSrc      = require 'gulp-add-src'
cache       = require 'gulp-cached'
coffee      = require 'gulp-coffee'
coffeeLint  = require 'gulp-coffeelint'
annotate    = require 'gulp-ng-annotate'
plumber     = require 'gulp-plumber'
remove      = require 'gulp-remove-code'
stripDebug  = require 'gulp-strip-debug'
runSequence = require 'run-sequence'


gulp.task 'coffee',  ->
  gulp.src(config.build.app_files.coffee)
  .pipe(plumber( (error) ->
      GLOBAL.coffeeOK = false

      if config.arguments.production
        throw new Error error.message
    ))
  .pipe(cache('coffeeBuild'))
  .pipe(coffeeLint())
  .pipe(coffeeLint.reporter())
  .pipe(coffeeLint.reporter('fail'))
  .pipe(coffee({bare: true}))
  .pipe(annotate())
  .pipe(gulp.dest(config.buildDir))

# ## Production build tasks

# ### TEMP DIR
gulp.task 'coffee-prod-build', ->
  gulp.src(config.build.app_files.all_coffee)
  .pipe(coffeeLint())
  .pipe(coffeeLint.reporter())
  .pipe(coffeeLint.reporter('fail'))
  .pipe(remove({developmentOnly: true}))
  .pipe(coffee({bare: true}))
  .pipe(stripDebug())
  .pipe(gulp.dest(config.prod.plain))

gulp.task 'coffee-prod-annotate', ['coffee-prod-build'], ->
  gulp.src(config.prod.jsNotAnnotated)
  .pipe(annotate())
  .pipe(gulp.dest(config.prod.jsAnnotated))


# ### MID DIR
gulp.task 'coffee-prod-mid-build', ->
  gulp.src(config.build.app_files.coffee)
  .pipe(coffeeLint())
  .pipe(coffeeLint.reporter())
  .pipe(coffeeLint.reporter('fail'))
  .pipe(remove({production: true, developmentOnly: true}))
  .pipe(coffee({bare: true}))
  .pipe(stripDebug())
  .pipe(gulp.dest(config.prod.build))


gulp.task 'coffee-prod-mid-build-annotate', ['coffee-prod-mid-build'], ->
  gulp.src(config.prod.buildNotAnnotated)
  .pipe(annotate())
  .pipe(gulp.dest(config.prod.buildAnnotated))


