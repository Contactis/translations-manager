# require build config
config = require '../variables'

# Require all dependencies
gulp        = require 'gulp'
runSequence = require 'run-sequence'
gulp-watch  = require 'gulp-watch'
chalk       = require 'chalk'

gulp.task 'watchers', ->

  # ## Set up basic watch groups and run group specific tasks only to save time in development mode
  # ## interval and pool mode must be set in order for boot2docker (OSX) to work

  if config.arguments.b2d
    watchersConfig = {interval: 1000, mode: 'poll'}
    console.log chalk.white.bgBlue '[GULP] Watchers in '+ chalk.white.bold.bgBlue 'boot2docker ' + chalk.white.bgBlue 'mode'
  else
    watchersConfig = {}

  # ### Coffee Script
  coffeeWatchArgs =
    source: config.build.app_files.coffee
    tasks:  ['coffee']

  if config.arguments.tests
    coffeeWatchArgs.tasks.push 'run-tests-watch'
    coffeeWatchArgs.source = config.build.app_files.all_coffee

  if config.arguments.docs
    coffeeWatchArgs.tasks.push 'run-docs'

  coffeeWatcher = gulp.watch coffeeWatchArgs.source, watchersConfig, ->
    runSequence coffeeWatchArgs.tasks


  # ### Jade templates
  jadeWatcher = gulp.watch config.build.app_files.jade_all_templates, watchersConfig, ->
    runSequence 'compile-jade'


  # ## Sass stylesheets
  sassWatcher = gulp.watch config.build.app_files.sass_all, watchersConfig, ->
    runSequence 'build-styles'

  # ## Additional tasks to run on file change

  coffeeWatcher.on 'change', (e) ->
    console.log chalk.yellow '[COFFEE] ' + chalk.yellow e.path

  coffeeWatcher.on 'add', (e) ->
    setTimeout () ->
      runSequence 'html-injector'
    , 1000
    console.log chalk.yellow '[NEW COFFEE FILE INJECTED] ' + chalk.yellow e

  sassWatcher.on 'change', (e) ->
    console.log chalk.yellow '[SASS] ' + chalk.yellow e.path

  jadeWatcher.on 'change', (e) ->
    console.log chalk.yellow '[JADE] ' + chalk.yellow e.path
    if e.path.match(/partial.jade/)
      config.arguments.jadeCache = false
      console.log chalk.blue '[JADE] Partial file had been modified. Running JADE without cache'

