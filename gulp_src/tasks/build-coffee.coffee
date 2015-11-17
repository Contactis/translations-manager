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


# @method       coffee
# @type         gulp
# @description  Lint, bake, annotate and drop compiled coffee to JS files into
#               `config.buildDir`
gulp.task 'coffee',  ->
  gulp.src(config.build.app_files.coffee)
  .pipe(plumber( (error) ->
    GLOBAL.coffeeOK = false
    if config.arguments.production
      throw new Error error.message
    else
      console.log error.message
  ))
  .pipe(cache('coffeeBuild'))
  .pipe(coffeeLint())
  .pipe(coffeeLint.reporter())
  .pipe(coffeeLint.reporter('fail'))
  .pipe(coffee({bare: true}))
  .pipe(annotate())
  .pipe(gulp.dest(config.buildDir))


# @method       coffee-tmp-prod
# @type         gulp
# @description  Lint, bake, annotate and drop compiled coffee to JS files into
#               `config.prod.tmpBuildDir`
gulp.task 'coffee-tmp-prod', ->
  gulp.src(config.build.app_files.coffee)
  .pipe(coffeeLint())
  .pipe(coffeeLint.reporter())
  .pipe(coffeeLint.reporter('fail'))
  .pipe(remove({developmentOnly: true}))
  .pipe(coffee({bare: true}))
  .pipe(stripDebug())
  .pipe(annotate())
  .pipe(gulp.dest(config.prod.tmpBuildDir))
