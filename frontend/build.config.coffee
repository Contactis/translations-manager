# This file/module contains all configuration for the build process.

module.exports =

  backendDir:   'backend'
  frontendDir:  'frontend'

#    Global filenames for html templates

  tpl_name:       'templates-module.js'
  tpl_module:     'templates-module'

  gulp_build_dir: 'public'

  #  Global filenames for html templates
  project_theme_name: 'theme_material'

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
    js: [
      # independent libraries
      'frontend/vendor/lodash/dist/lodash.js'
      # Angular lib should be the last of independent list!
      'frontend/vendor/angular/angular.js'

      # Libraries depends on independent libraries
      'frontend/vendor/angular-animate/angular-animate.js'
      'frontend/vendor/angular-cookies/angular-cookies.js'
      'frontend/vendor/angular-resource/angular-resource.js'
      'frontend/vendor/angular-aria/angular-aria.min.js'
      'frontend/vendor/angular-lodash/angular-lodash.js'
      'frontend/vendor/angular-material/angular-material.js'
      'frontend/vendor/angular-ui-router/release/angular-ui-router.js'
      'frontend/vendor/angular-translate/angular-translate.js'
      'frontend/vendor/restangular/src/restangular.js'
      'frontend/vendor/angular-data-table/release/dataTable.helpers.min.js'
      'frontend/vendor/angular-messages/angular-messages.js'

      'frontend/vendor/messageformat/messageformat.js'
      'frontend/vendor/messageformat/locale/en.js'
      'frontend/vendor/messageformat/locale/pl.js'
      'frontend/vendor/angular-translate-interpolation-messageformat/angular-translate-interpolation-messageformat.js'
      'frontend/vendor/angular-dynamic-locale/dist/tmhDynamicLocale.js'



      'frontend/vendors_offline/common.js'
      'frontend/vendors_offline/permissionConfig.js'
      ]

    css: [
      'frontend/vendor/angular-material/angular-material.css'
      'frontend/vendor/angular-data-table/release/dataTable.css'
      'frontend/vendor/angular-data-table/release/material.css'
    ]

    assets: ''

#    This is a collection of file patterns that refer to our app code (the
#    stuff in `src/`). These file paths are used in the configuration of
#    build tasks. `js` is all project JavaScript, less tests. `common_tpl`
#    contains
#    our reusable components' (`src/common`) template HTML files, while
#    `app_tpl` contains the same, but for our app's code. `html` is just our
#    main HTML file, `less` is our main style-sheet, and `unit` contains our
#    app's unit tests.



  app_files:

    coffee:   [
      'frontend/**/*.coffee'
      '!frontend/**/*.spec.coffee'
      '!frontend/build.config.coffee'
      '!frontend/vendor/**/*.coffee'
      '!frontend/vendors_offline/**/*.coffee'
    ]

    all_coffee:         'frontend/**/*.coffee'
    gulp_files:         'gulp/**/*.coffee'
    git_commit:         'src/assets/gitcommit.js'

    jade_app_tpl:       'frontend/app/**/*.jade'
    jade_common_tpl:    'frontend/common/**/*.jade'
    jade_all_templates: 'frontend/**/*.jade'

    assets:   [ 'frontend/assets/**']
    html:     [ 'frontend/index.html' ]


#    This is a collection of files used during testing only.

  test_files:
    js:
      'vendor/angular-mocks/angular-mocks.js'






