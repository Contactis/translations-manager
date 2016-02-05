# require build config
config = require '../variables'

plumber = require 'gulp-plumber'
gulp    = require 'gulp'
del     = require 'del'

gulp.task 'clean', ->
  del.sync [
    config.buildDir
  ], {force: true}

gulp.task 'clean-all', ->
  del.sync [
    config.gulpDir
  ], {force: true}

gulp.task 'clean-docs', ->
  del.sync [
    config.build.docs_dir
  ], {force: true}

gulp.task 'clean-tests', ->
  del.sync [
    config.testsDir
  ], {force: true}

gulp.task 'clean-prod', ->
  del.sync [
    config.prod.plain,
    config.prod.jsAnnotated
  ], {force: true}

