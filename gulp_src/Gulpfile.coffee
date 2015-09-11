# require build config
config = require './variables'

gulp = require 'gulp'
os   = require 'os'

# Require files with individual build tasks
require './tasks/about'
require './tasks/build'
require './tasks/build-html'
require './tasks/build-styles'
require './tasks/build-assets'
require './tasks/build-coffee'
require './tasks/build-jade'
require './tasks/build-js'
require './tasks/helpers'
require './tasks/watchers'

# ## Determine if gulp is running inside boot2docker VM or on a linux host
osRelease = os.release()
if osRelease.indexOf('boot2docker') >= 0
  config.arguments.b2d = true


gulp.task 'default', ['describe-myself']
