# ## This file provides us with variables interface
# ## which can be included in every file in need. DRY!

buildConfig = require '../build.config'
pkg         = require '../package.json'
argv        = require('yargs').argv

GLOBAL.coffeeOK = true

module.exports =
  build:      buildConfig
  pkg:        pkg
  gulpDir:    buildConfig.gulp_build_dir
  buildDir:   buildConfig.gulp_build_dir + '/build'
  testsDir:   buildConfig.gulp_build_dir + '/tests'
  testsSrc:   if (typeof  argv['testing-dir'] is "undefined") then buildConfig.gulp_build_dir + '/tests' else buildConfig.gulp_build_dir + '/tests/' + argv['testing-dir']
  testsBuild: if (typeof  argv['testing-dir'] is "undefined") then buildConfig.gulp_build_dir + '/build' else buildConfig.gulp_build_dir + '/build/' + argv['testing-dir']
  prod:
    plain:              buildConfig.gulp_build_dir + '/tmp/plain-js'
    jsNotAnnotated:     [buildConfig.gulp_build_dir + '/tmp/plain-js/**/*.js', '!' + buildConfig.gulp_build_dir + '/tmp/plain-js/**/*.spec.js']
    jsAnnotated:        buildConfig.gulp_build_dir + '/tmp/build'
    build:              buildConfig.gulp_build_dir + '/mid/not-annotated'
    buildNotAnnotated:  buildConfig.gulp_build_dir + '/mid/not-annotated/**/*.js'
    buildAnnotated:     buildConfig.gulp_build_dir + '/mid/build'
    buildTests:         buildConfig.gulp_build_dir + '/mid/tests'

  arguments:
    tests:      if (typeof argv.tests is "undefined") or (argv.tests is true) then true else false
    docs:       if (typeof argv.docs is "undefined") or (argv.docs is true) then true else false
    uglify:     if (typeof argv.uglify is "undefined") or (argv.uglify is true) then true else false
    production: false
    b2d:        false
    jadeCache:  true
