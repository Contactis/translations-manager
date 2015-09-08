# This file/module contains all configuration for the build process.

module.exports =

  # The `build_priv` and `build_pub` folder is where our projects are
  # compiled during development process. `build_priv` contains complete
  # project build for private and public tests, `build_pub` contains
  # complete project build ONLY for public test (private tests was stripped)
  #
  # The `tmp_priv` and `tmp_pub` are only staging containers during building
  # processes.
  #
  # The `compile_dir` folder is where our app resides once it's
  # completely built.
  build_dir:        'build_pub'
  tmp_dir:          'tmp_pub'
  compile_dir:      'production'
  gulp_build_dir:   'gulp-build'
  docs_dir:         'gulp-build/docs'


  # Global filenames for html templates
  tpl_name:   'templates-module.js'
  tpl_module: 'templates-module'


  # Global filenames for html templates
  project_theme_name: 'theme_material'


  # These vars are overwritten in tasks :
  # `set_vars_for_build_process_priv` and `set_vars_for_build_process_pub`
  # DO NOT CHANGE THEM HERE, BECAUSE THEY'LL BE OVERWRITTEN ANYWAY
  # If you want to change build and temp directory locations
  # look above into `build_dir_priv` and `build_dir_pub` and so on...
  build_dir:  'default_value_for_build_dir_changed_in-task'
  tmp_dir:    'default_value_for_temp_dir_changed_in-task'
  test_blocks:
    start:    'test-block-start'
    end:      'test-block-end'


  # This is a collection of file patterns that refer to our app code (the
  # stuff in `src/`). These file paths are used in the configuration of
  # build tasks. `js` is all project JavaScript, less tests. `common_tpl` contains
  # our reusable components' (`src/common`) template HTML files, while
  # `app_tpl` contains the same, but for our app's code. `html` is just our
  # main HTML file, `less` is our main style-sheet, and `unit` contains our
  # app's unit tests.
  app_files:
    js: [
      'src/**/*.js'
      '!src/**/*.spec.js'
      '!src/assets/**/*.js'
      '!src/sass/**/*.js'
    ]
    jsunit: [ 'src/**/*.spec.js' ]
    coffee: [
      'src/**/*.coffee'
      '!src/**/*.spec.coffee'
    ]
    coffeeunit: [ 'src/**/*.spec.coffee' ]
    all_coffee: 'src/**/*.coffee'
    gulp_files: 'gulp/**/*.coffee'
    git_commit: 'src/assets/gitcommit.js'
    jade_app_tpl: 'src/app/**/*.jade'
    jade_common_tpl: 'src/common/**/*.jade'
    jade_all_templates: 'src/**/*.jade'
    assets: [ 'src/assets/**' ]
    html: [ 'src/index.html' ]
    less: [ 'src/less/main.less' ]
    sass: [
      'src/sass/main.sass'
      'src/app/**/*.sass'
      'src/common/**/*.sass'
    ]
    sass_all: [
      'src/sass/**/*.sass'
      'src/sass/**/*.scss'
    ]

  # This is a collection of file patterns that refer ONLY to building process
  # These patterns relay on global variable `tmp_dir` and cannot work properly
  # without setting `tmp_dir` first.
  tmp_app_files:
    js: [
      '<%= tmp_dir %>/**/*.js'
      '!<%= tmp_dir %>/**/*.spec.js'
      '!<%= tmp_dir %>/assets/**/*.js'
    ]
    jsunit: [ '<%= tmp_dir %>/**/*.spec.js' ]
    coffee: [
      '<%= tmp_dir %>/**/*.coffee'
      '!<%= tmp_dir %>/**/*.spec.coffee'
    ]
    coffeeunit: [ '<%= tmp_dir %>/**/*.spec.coffee' ]
    app_tpl: [ '<%= tmp_dir %>/src/app/**/*.tpl.html' ]
    common_tpl: [ '<%= tmp_dir %>/src/common/**/*.tpl.html' ]

  # This is a collection of files used during testing only.

  test_files: js: [
    'vendor/angular-mocks/angular-mocks.js'
    'vendor/jasmine-jquery/lib/jasmine-jquery.js'
  ]


  # The `vendor_files.js` property holds files to be automatically
  # concatenated and minified with our project source files.
  #
  # The `vendor_files.css` property holds any CSS files to be automatically
  # included in our app.
  #
  # The `vendor_files.assets` property holds any assets to be copied along
  # with our app's assets. This structure is flattened, so it is not
  # recommended that you use wildcards.
  vendor_files:
    js: [
      # Independent libraries
      'vendor/angular/angular.js'

      # Libraries depends on independent libraries
      'vendor/jquery-ui/ui/jquery-ui.js'
    ]

    # Includes external css libraries BEFORE other sass files
    css: [
      # additional CSS libs (only in CSS format)
    ]
    assets: []
