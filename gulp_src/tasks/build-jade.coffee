# require build config
config = require '../variables'

gulp          = require 'gulp'
cache         = require 'gulp-cached'
jade          = require 'gulp-jade'
templateCache = require 'gulp-angular-templatecache'
remember      = require 'gulp-remember'
plumber       = require 'gulp-plumber'
uglify        = require 'gulp-uglify'
gulpif        = require 'gulp-if'
deepcopy      = require 'deepcopy'
cback         = require 'gulp-callback'

consoleWarn = deepcopy console.warn

# @private
# @method       console.warn
# @param        {String}  args   String message to log
# @description  Display console log and exit.
console.warn = (args) ->
  console.log args
  process.exit()


# @private
# @method       _jadeCore
# @description  Build HTML templates from JADE template engine and save them
#               with `.tpl.html` extension.
_jadeCore = ->
  gulp.src([
    config.build.app_files.jade_app_tpl
    config.build.app_files.jade_common_tpl
    '!frontend/**/*.partial.jade'
  ])
  .pipe(plumber( (error) ->
      GLOBAL.coffeeOK = false
      if config.arguments.production
        throw new Error error.message
      else
        console.log "[JADE] error: ", error.message
    ))
  .pipe(gulpif((!config.arguments.production && config.arguments.jadeCache), cache('jade-templates')))
  .pipe(jade({
      client: false
      pretty: true
    }))
  .pipe(gulpif((!config.arguments.production && config.arguments.jadeCache), remember('jade-templates')))
  .pipe(templateCache(config.build.tpl_name, {
      module: config.build.tpl_module
      standalone: true
      transformUrl: (url) ->
        return url.replace(/.html$/, '.tpl.html')
    }))


# @method       compile-jade
# @type         gulp-task
# @description  Compiling JADE to HTML into `buildDir` (not uglified)
gulp.task 'compile-jade', ->
  _jadeCore()
  .pipe(gulp.dest(config.buildDir))
  .pipe cback ->
    console.warn = consoleWarn
    config.arguments.jadeCache = true


# @method       compile-jade-tmp-prod
# @type         gulp-task
# @description  Compiling JADE to HTML into temp. directory with uglification
gulp.task 'compile-jade-tmp-prod', ->
  _jadeCore()
  .pipe(uglify())
  .pipe(gulp.dest(config.prod.tmpBuildDir))
  .pipe cback ->
    console.warn = consoleWarn
    config.arguments.jadeCache = true
