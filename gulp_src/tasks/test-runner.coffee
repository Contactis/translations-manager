# # Gulp test-runner.coffee

# require build config
config = require '../variables'

gulp        = require 'gulp'
runSequence = require 'run-sequence'
coffeeLint  = require 'gulp-coffeelint'
coffee      = require 'gulp-coffee'
cache       = require 'gulp-cached'
plumber     = require 'gulp-plumber'
remove      = require 'gulp-remove-code'
gulpif      = require 'gulp-if'
karma       = require 'gulp-karma'
Server      = require('karma').Server


# Vendor files loaded from build config file.
# They allow project to load up and execute tests in testing environment
vendorFiles = []

config.build.vendor_files.js.forEach (val) ->
  vendorFiles.push __dirname + '/../../' + val

config.build.test_files.js.forEach (val) ->
  vendorFiles.push __dirname + '/../../' + val


# @private
# @method       _testBuilder
# @description  Default tests builder moved into a single function to keep the code clean
_testBuilder = ->
  gulp.src(config.build.app_files.coffeeunit)
  .pipe(plumber( (error) ->
      GLOBAL.coffeeOK = false
      if config.arguments.production
        throw new Error error.message
    ))
  .pipe(coffeeLint())
  .pipe(coffeeLint.reporter())
  .pipe(coffeeLint.reporter('fail'))
  .pipe(gulpif(!config.arguments.production, remove({production: true})))
  .pipe(coffee({bare: true}))


# @method       run-karma
# @type         gulp-task
# @description  Run test on test files against source files and put them into
#               testsDir
gulp.task 'build-tests', ->
  _testBuilder()
  .pipe(gulp.dest(config.testsDir))


# @method       run-karma
# @type         gulp-task
# @description  Run tests files against source files for DEVELOPMENT
gulp.task 'run-karma', (done) ->
  sources = [
    __dirname + '/../../' + config.buildDir + '/app/**/*.js'
    __dirname + '/../../' + config.buildDir + '/common/**/*.js'
    __dirname + '/../../' + config.buildDir + '/' + config.build.tpl_name
  ]
  sources.push __dirname + '/../../' + config.testsSrc + "/**/*.js"
  _files = vendorFiles.concat sources

  server = new Server {
    configFile:       __dirname + '/karma-dev.config.coffee'
    files:            _files
  }, ->
    done()
  server.start()


# @method       run-karma-prod
# @type         gulp-task
# @description  Run tests files against JS source file (concat & uglify)
#               for PRODUCTION. It depends on
gulp.task 'run-karma-prod', (done) ->
  sources = [
    __dirname + '/../../' + config.buildDir + '/' + config.prod.jsDeployFileName
  ]
  sources.push __dirname + '/../../' + config.testsSrc + "/**/*.js"
  _files = vendorFiles.concat sources

  server = new Server {
    configFile:       __dirname + '/karma-prod.config.coffee'
    files:            _files
  }, ->
    done()
  server.start()


# @private
# @method       _afterTestsBuild
# @description  Run project tests for DEVELOPMENT.
_afterTestsBuild = (done) ->
  if GLOBAL.coffeeOK
    if config.arguments.production
      runSequence 'run-karma-prod', ->
        done()
    else
      runSequence 'run-karma', ->
        done()
  else
    GLOBAL.coffeeOK = true
    done()


# @method       run-tests
# @type         gulp-task
# @description  GULP task to fire project tests for DEVELOPMENT.
gulp.task 'run-tests', (done) ->
  runSequence 'clean-tests', 'build-tests', ->
    _afterTestsBuild(done)


# @method       run-tests-prod
# @type         gulp-task
# @description  GULP task to fire project tests for PRODUCTION.
gulp.task 'run-tests-prod', (done) ->
  runSequence 'clean-tests', 'build-tests', ->
    _afterTestsBuild(done)


# @method       run-tests-watch
# @type         gulp-task
# @description  Gulp task fired only tests when **source** or **test** files
#               are changed.
gulp.task 'run-tests-watch', (done) ->
  runSequence 'build-tests', ->
    _afterTestsBuild(done)
