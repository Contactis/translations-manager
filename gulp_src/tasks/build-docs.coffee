# require build config
config = require '../variables'

# config variables
gulp  = require 'gulp'
shell = require 'gulp-shell'

# tasks
gulp.task 'run-docs', shell.task [ "groc"]
gulp.task 'build-docs', ['clean-docs', 'run-docs']
