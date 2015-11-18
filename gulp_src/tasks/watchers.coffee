# require build config
config = require '../variables'

# Require all dependencies
gulp        = require 'gulp'
runSequence = require 'run-sequence'
gulp-watch  = require 'gulp-watch'
chalk       = require 'chalk'

gulp.task 'watchers', ->

  # ### Coffee Script
  coffeeWatchArgs =
    source: config.build.app_files.coffee
    tasks:  ['coffee']

  if config.arguments.tests
    coffeeWatchArgs.tasks.push 'run-tests-watch'
    coffeeWatchArgs.source = config.build.app_files.all_coffee

  if config.arguments.docs
    coffeeWatchArgs.tasks.push 'run-docs'

  coffeeWatcher = gulp.watch coffeeWatchArgs.source, ->
    runSequence coffeeWatchArgs.tasks


  # ### Jade templates
  jadeWatcher = gulp.watch config.build.app_files.jade_all_templates,  ->
    runSequence 'compile-jade'


  # ## Sass stylesheets
  sassWatcher = gulp.watch config.build.app_files.sass, ->
    runSequence 'build-styles'

  # ## Backend
  gulp.watch config.build.backendDir + '/**/*.coffee', ['lint-backend']

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

