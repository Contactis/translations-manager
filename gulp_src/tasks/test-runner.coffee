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
  .pipe(gulpif(config.arguments.production, remove({production: true})))
  .pipe(coffee({bare: true}))


# ## DEVELOPMENT TASKS
gulp.task 'build-tests', ->
  _testBuilder()
  .pipe(gulp.dest(config.testsDir))


gulp.task 'run-karma', (done) ->
  sources = [
    __dirname + '/../../' + config.buildDir + '/assets/gitcommit.js'
    __dirname + '/../../' + config.buildDir + '/app/**/*.js'
    __dirname + '/../../' + config.buildDir + '/common/**/*.js'
    __dirname + '/../../' + config.buildDir + '/' + config.build.tpl_name
  ]
  sources.push __dirname + '/../../' + config.testsSrc + "/**/*.js"
  _files = vendorFiles.concat sources
  Server = new Server({
    configFile:       __dirname + '/karma.config.coffee'
    files:            _files
  }, done)
  Server.start()



afterTestsBuild = (done) ->
  if GLOBAL.coffeeOK
    runSequence 'run-karma', done
  else
    GLOBAL.coffeeOK = true
    done()


# @method       run-tests
# @type         gulp
# @description  Run tests for the project.
gulp.task 'run-tests', (done) ->
  runSequence 'clean-tests', 'build-tests', ->
    afterTestsBuild(done)


# @method       run-tests-watch
# @description  Run only tests when **source** or **test** files are changed.
gulp.task 'run-tests-watch', (done) ->
  runSequence 'build-tests', ->
    afterTestsBuild(done)
# ## END DEVELOPMENT TASKS



# ##### PRODUCTION TASKS

# ### $ gulp production divides build process into three stages
# ### each stage gets it's own sets of tests


# @method       run-karma-prod-tmp
# @description  First stage, tests are run from common directory.
#               No need for separate build
gulp.task 'run-karma-prod-tmp', (done) ->

  sources = [
    __dirname + '/../../' + config.prod.jsAnnotated + '/app/**/*.js'
    __dirname + '/../../' + config.prod.jsAnnotated + '/common/**/*.js'
    __dirname + '/../../' + config.prod.jsAnnotated + '/' + config.build.tpl_name
  ]

  sources.push __dirname + '/../../' + config.prod.plain + "/**/*.spec.js"

  files = vendorFiles.concat sources

  karmaSettings.preprocessors[__dirname + '/../../' + config.prod.jsAnnotated + '/**/*.js'] = ['coverage']
  karmaSettings.coverageReporter['dir'] = __dirname + '/../../' + config.build.gulp_build_dir + '/test-coverage/tmp'

  gulp.src files
  .pipe karma karmaSettings



# ### Second stage, private tests.
# Builds tests with private code parts removed. We call this part "public build"

# @method       build-karma-prod-mid
gulp.task 'build-karma-prod-mid', ->
  _testBuilder()
  .pipe(gulp.dest(config.prod.buildTests))

gulp.task 'run-karma-prod-mid', ['build-karma-prod-mid'], (done) ->


  sources = [
    __dirname + '/../../' + config.prod.buildAnnotated + '/app/**/*.js'
    __dirname + '/../../' + config.prod.buildAnnotated + '/common/**/*.js'
    __dirname + '/../../' + config.prod.buildAnnotated + '/' + config.build.tpl_name
  ]

  sources.push __dirname + '/../../' + config.prod.buildTests + "/**/*.js"

  files = vendorFiles.concat sources

  karmaSettings.preprocessors[__dirname + '/../../' + config.prod.buildAnnotated + '/**/*.js'] = ['coverage']
  karmaSettings.coverageReporter['dir'] = __dirname + '/../../' + config.build.gulp_build_dir + '/test-coverage/mid'

  gulp.src files
  .pipe karma karmaSettings


# ### Third and last build stage. It doesn't include any vendor files because they are all included in
# ### one app file. All that needs to be included are ngMocks and tests files, which had been build in previous stage

gulp.task 'run-karma-prod-final', (done) ->

  files = []

  config.build.test_files.js.forEach (val) ->
    files.push __dirname + '/../../' + val

  sources = [
    __dirname + '/../../' + config.buildDir + '/*.js'
  ]

  sources = sources.concat files

  sources.push __dirname + '/../../' + config.prod.buildTests + "/**/*.js"


  delete karmaSettings.coverageReporter
  delete karmaSettings.reporters[1]

  gulp.src sources
  .pipe karma karmaSettings

# ##### END PRODUCTION TASKS
