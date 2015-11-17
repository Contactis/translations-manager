# require build config
config = require '../variables'

# Require all dependencies
gulp        = require 'gulp'
runSequence = require 'run-sequence'
chalk       = require 'chalk'

buildProdArgs =
  tmp:
    stage1: ['clean-all']
    stage2: ['coffee-prod-annotate', 'compile-jade-prod-tmp']
    stage3: ['run-karma-prod-tmp']
  mid:
    stage1: ['coffee-prod-mid-build-annotate', 'compile-jade-prod-mid']
    stage2: ['run-karma-prod-mid']
  final:
    stage1: ['build-js', 'build-styles', 'build-assets']
    stage2: ['run-karma-prod-final']
    stage3: ['build-html-prod']
    stage4: ['build-docs']

gulp.task 'production', ->

  buildStart = Date.now()
  config.arguments.production = true

  runSequence buildProdArgs.tmp.stage1, buildProdArgs.tmp.stage2, buildProdArgs.tmp.stage3, buildProdArgs.mid.stage1, buildProdArgs.mid.stage2, buildProdArgs.final.stage1, buildProdArgs.final.stage2, buildProdArgs.final.stage3, buildProdArgs.final.stage4, ->
    diff = String((Date.now() - buildStart) / 1000)
    console.log chalk.white.bgGreen '[GULP] Build sequence had been completed successfully in ' + chalk.white.bgGreen diff + chalk.white.bgGreen 's!'
    config.arguments.production = false
