# require build config
config = require '../variables'

# Require all dependencies
gulp        = require 'gulp'
runSequence = require 'run-sequence'
chalk       = require 'chalk'

buildProdArgs =
  stage1: ['clean-all']
  stage2: ['coffee-tmp-prod', 'compile-jade-tmp-prod', 'loopback-models'] # making JS files
  stage3: ['build-js-prod', 'build-styles', 'build-assets']
  stage4: ['run-tests-prod'] # run tests on prepared to deploy JS files
  stage5: ['build-index-html-prod']
  stage6: ['build-docs']


# @method       production
# @type         gulp-task
# @description  Run all gulp tasks related with PRODUCTION
gulp.task 'production', ->
  buildStart = Date.now()
  config.arguments.production = true
  config.arguments.uglify     = true

  if config.arguments.nodemon
    buildProdArgs.stage6.push 'nodemon'

  runSequence buildProdArgs.stage1, buildProdArgs.stage2, buildProdArgs.stage3, buildProdArgs.stage4, buildProdArgs.stage5, buildProdArgs.stage6, ->
    diff = String((Date.now() - buildStart) / 1000)
    console.log chalk.white.bgGreen '[GULP] Build sequence had been completed successfully in ' + chalk.white.bgGreen diff + chalk.white.bgGreen 's!'
    config.arguments.production = false
    config.arguments.uglify     = false


# @method       production-without-nodemon
# @type         gulp-task
# @description  Run all gulp tasks related with PRODUCTION but without nodemon
#               server. This is **ONLY** for testing purpose to complete it after
#               run karma (nodemon not ends, it is a service).
gulp.task 'production-without-nodemon', (done) ->
  config.arguments.nodemon = false
  console.log chalk.white.bgGreen '[GULP] Starting production task without nodemon'
  runSequence 'production', ->
    done()
