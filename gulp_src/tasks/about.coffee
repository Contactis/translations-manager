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

  console.log "#{chalk.inverse '$ gulp ANY --no-tests allows' }\nUs to work with the project without running karma tests. This mode speeds up development process even more but requires additional caution when pushing and deploying code. It is recommended to run $ gulp build before pushing to the repository in this mode.\n"
  console.log "#{chalk.inverse '$ gulp ANY --testing-dir=PATH' }\nLet us run tests and coverage reports only for a selected directory path. In a case a project contains +1000 unit tests this approach allows us to save time by running only small batch of tests to save time and resources.\n"
  console.log "#{chalk.inverse '$ gulp ANY --no-docs' }\nAllows us to work with the project without tests being build.\n"
  console.log "#{chalk.inverse '$ gulp production' }\nSets up project for production environment. Concatenates all js and coffee files into one, minifies that file along with index.html. In addition it keeps all the steps in between cached for easier debuging later on.\n"
  console.log "#{chalk.inverse '$ gulp production --no-uglify' }\nTurns off gulp-uglify task in order to save time while working on the build process itself.\n"
