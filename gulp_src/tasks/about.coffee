gulp  = require 'gulp'
chalk = require 'chalk'

gulp.task 'describe-myself', ->
  console.log ''
  console.log chalk.bgBlue.white "This is a default task. It will do nothing, just list awesome available options :)"
  console.log ''
  console.log "#{chalk.inverse '$ gulp build '}"
  console.log "This task is compiling whole project in development mode without minified files.\n"
  console.log "#{chalk.inverse '$ gulp watch '}"
  console.log "This task will be the one most commonly used in development process. It starts off with gulp build then sets up watchers on three main parts of our codebase: styles, templates, coffee script files and compiles them on the fly to speed up development process.
All gulp tasks can be run w:ith additional flags to meet our current needs.\n"

  console.log "#{chalk.inverse '$ gulp production' }\nSets up project for production environment. Concatenates all js and coffee files into one, minifies that file along with index.html. In addition it keeps all the steps in between cached for easier debuging later on.\n"
  console.log "#{chalk.inverse '$ gulp production --no-uglify' }\nTurns off gulp-uglify task in order to save time while working on the build process itself.\n"
