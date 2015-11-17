# require build config
config = require '../variables'

# Require all dependencies
gulp        = require 'gulp'
runSequence = require 'run-sequence'
gulp-watch  = require 'gulp-watch'
chalk       = require 'chalk'

buildArgs =
  stage1: ['clean-all']
  stage2: [
    'coffee'
    'loopback-models'
    'compile-jade'
    'build-styles'
    'build-assets'
  ]
  stage3: ['build-index-html']
  stage4: ['nodemon']


# @method       build
# @type         gulp-task
# @description  Begin standard project build in stages order: stage1, stage2,
#               stage3 and stage4.
gulp.task 'build', (done) ->
  buildStart = Date.now()

  if config.arguments.tests
    buildArgs.stage3.push 'run-tests'

  if config.arguments.docs
    buildArgs.stage2.push 'build-docs'

  runSequence buildArgs.stage1, buildArgs.stage2, buildArgs.stage3, buildArgs.stage4, ->
    diff = String((Date.now() - buildStart) / 1000)
    console.log chalk.white.bgGreen '[GULP] Build sequence had been completed successfully in ' + chalk.white.bgGreen diff + chalk.white.bgGreen 's!'
    done()


# @method       watch
# @type         gulp-task
# @description  Begin standard project deployment and run watcher on the end to
#               constantly observing changes in files.
gulp.task 'watch', (done) ->
  console.log chalk.white.bgGreen '[GULP] Starting watch and build task'
  runSequence  'build', 'watchers', ->
    console.log chalk.white.bgGreen '[GULP] Watchers had been turned on'
    done()
