# require build config
config = require '../variables'

# config variables
gulp  = require 'gulp'
shell = require 'gulp-shell'


# @method       run-docs
# @type         gulp-task
# @description  Run task for making documentation
gulp.task 'run-docs', shell.task ["groc"]


# @method       build-docs
# @type         gulp-task
# @description  Build whole documentation for the project
gulp.task 'build-docs', ['clean-docs', 'run-docs']
