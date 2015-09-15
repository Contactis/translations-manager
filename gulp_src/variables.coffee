# ## This file provides us with variables interface
# ## which can be included in every file in need. DRY!

buildConfig = require '../frontend/build.config.coffee'
pkg         = require '../package.json'
argv        = require('yargs').argv

GLOBAL.coffeeOK = true

module.exports =
  build:      buildConfig
  pkg:        pkg
  gulpDir:    buildConfig.gulp_build_dir
  buildDir:   'public'
  prod:
    buildAnnotated:     buildConfig.gulp_build_dir + '/mid/build'

  arguments:
    production: false
    jadeCache:  true
