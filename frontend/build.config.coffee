# This file/module contains all configuration for the build process.

module.exports =

  backendDir:   'backend'
  frontendDir:  'frontend'



  gulp_build_dir: 'gulp-build'







  #  Global filenames for html templates
  project_theme_name: 'theme_beta'





#    This is the same as `app_files`, except it contains patterns that
#    reference vendor code (`vendor/`) that we need to place into the build
#    process somewhere. While the `app_files` property ensures all
#    standardized files are collected for compilation, it is the user's job
#    to ensure non-standardized (i.e. vendor-related) files are handled
#    appropriately in `vendor_files.js`.
#
#    The `vendor_files.js` property holds files to be automatically
#    concatenated and minified with our project source files.
#
#    The `vendor_files.css` property holds any CSS files to be automatically
#    included in our app.
#
#    The `vendor_files.assets` property holds any assets to be copied along
#    with our app's assets. This structure is flattened, so it is not
#    recommended that you use wildcards.

  vendor_files:
    js: 'vendor/jquery/dist/jquery.js'
    assets: ''


#    This is a collection of file patterns that refer to our app code (the
#    stuff in `src/`). These file paths are used in the configuration of
#    build tasks. `js` is all project JavaScript, less tests. `common_tpl` contains
#    our reusable components' (`src/common`) template HTML files, while
#    `app_tpl` contains the same, but for our app's code. `html` is just our
#    main HTML file, `less` is our main style-sheet, and `unit` contains our
#    app's unit tests.



  app_files:
    js: [ 'src/**/*.js', '!src/**/*.spec.js', '!src/assets/**/*.js', '!src/sass/**/*.js' ]
    jsunit: [ 'src/**/*.spec.js' ]

    #coffee: [ 'src/**/*.coffee', '!src/**/*.spec.coffee' ],
    coffee:       [ 'src/**/*.coffee', '!src/**/*.spec.coffee' ]
    coffeeunit:   [ 'src/**/*.spec.coffee' ]
    all_coffee:   'src/**/*.coffee'
    gulp_files:   'gulp/**/*.coffee'

    git_commit:   'src/assets/gitcommit.js'

    jade_app_tpl: 'src/app/**/*.jade'
    jade_common_tpl: 'src/common/**/*.jade'
    jade_all_templates: 'src/**/*.jade'

    assets:   [ 'frontend/assets/**']
    html:     [ 'src/index.html' ]
    less:     [ 'src/less/main.less' ]
    sass:     [ 'src/sass/main.sass', 'src/app/**/*.sass', 'src/common/**/*.sass' ]
    sass_all: ['src/sass/**/*.sass', 'src/sass/**/*.scss']
