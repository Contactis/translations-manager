# require build config
config = require '../variables'

# Require all dependencies
gulp        = require 'gulp'
runSequence = require 'run-sequence'
gulp-watch  = require 'gulp-watch'
chalk       = require 'chalk'

buildArgs =
  stage1: ['clean-all']
  stage2: ['coffee', 'compile-jade', 'build-styles', 'build-assets']
  stage3: ['build-html', 'nodemon']


gulp.task 'build', (done) ->

  buildStart = Date.now()

  runSequence buildArgs.stage1, buildArgs.stage2, buildArgs.stage3, ->
    diff = String((Date.now() - buildStart) / 1000)
    console.log chalk.white.bgGreen '[GULP] Build sequence had been completed successfully in ' + chalk.white.bgGreen diff + chalk.white.bgGreen 's!'
    done()


gulp.task 'watch', (done) ->

  console.log chalk.white.bgGreen '[GULP] Starting watch and build task'
  runSequence  'build', 'watchers', ->
    console.log chalk.white.bgGreen '[GULP] Watchers had been turned on'
    done()
