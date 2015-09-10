/**
 * This file/module contains all configuration for the build process.
 */
module.exports = {
  /**
   * The `build_priv` and `build_pub` folder is where our projects are
   * compiled during development process. `build_priv` contains complete
   * project build for private and public tests, `build_pub` contains
   * complete project build ONLY for public test (private tests was stripped)
   *
   * The `tmp_priv` and `tmp_pub` are only staging containers during building
   * processes.
   *
   * The `compile_dir` folder is where our app resides once it's
   * completely built.
   */
  build_dir_priv: 'build_priv',
  build_dir_pub:  'build_pub',
  tmp_dir_priv:   'tmp_priv',
  tmp_dir_pub:    'tmp_pub',
  compile_dir:    'production',
  gulp_build_dir: 'gulp-build',
  docs_dir:       'gulp-build/docs',

  /**
   *  Global filenames for html templates
   */
  tpl_name:       'templates-module.js',
  tpl_module:     'templates-module',

  /**
   *  Global filenames for html templates
   */
  project_theme_name: 'theme_beta',

  /**
   * These vars are overwritten in tasks :
   * `set_vars_for_build_process_priv` and `set_vars_for_build_process_pub`
   * DO NOT CHANGE THEM HERE, BECAUSE THEY'LL BE OVERWRITTEN ANYWAY
   * If you want to change build and temp directory locations
   * look above into `build_dir_priv` and `build_dir_pub` and so on...
   */
  build_dir:  'default_value__for_build_dir_changed_in-task',
  tmp_dir:    'default_value_for_temp_dir_changed_in-task',

  test_blocks: {
    start:  'test-block-start',
    end:    'test-block-end'
  },

  /**
   * This is a collection of file patterns that refer to our app code (the
   * stuff in `src/`). These file paths are used in the configuration of
   * build tasks. `js` is all project JavaScript, less tests. `common_tpl` contains
   * our reusable components' (`src/common`) template HTML files, while
   * `app_tpl` contains the same, but for our app's code. `html` is just our
   * main HTML file, `less` is our main style-sheet, and `unit` contains our
   * app's unit tests.
   */
  app_files: {
    js: [ 'src/**/*.js', '!src/**/*.spec.js', '!src/assets/**/*.js', '!src/sass/**/*.js' ],
    jsunit: [ 'src/**/*.spec.js' ],

    // coffee: [ 'src/**/*.coffee', '!src/**/*.spec.coffee' ],
    coffee:       [ 'src/**/*.coffee', '!src/**/*.spec.coffee' ],
    coffeeunit:   [ 'src/**/*.spec.coffee' ],
    all_coffee:   'src/**/*.coffee',
    gulp_files:   'gulp/**/*.coffee',

    git_commit:   'src/assets/gitcommit.js',

    jade_app_tpl: 'src/app/**/*.jade',
    jade_common_tpl: 'src/common/**/*.jade',
    jade_all_templates: 'src/**/*.jade',

    assets:   ['frontend/assets/**'],
    html:     [ 'src/index.html' ],
    less:     [ 'src/less/main.less' ],
    sass:     [ 'src/sass/main.sass', 'src/app/**/*.sass', 'src/common/**/*.sass' ],
    sass_all: ['src/sass/**/*.sass', 'src/sass/**/*.scss']
  },

  /**
   * This is a collection of file patterns that refer ONLY to building process
   * These patterns relay on global variable `tmp_dir` and cannot work properly
   * without setting `tmp_dir` first.
   */
  tmp_app_files: {
    js: [ '<%= tmp_dir %>/**/*.js', '!<%= tmp_dir %>/**/*.spec.js',
          '!<%= tmp_dir %>/assets/**/*.js' ],
    jsunit: [ '<%= tmp_dir %>/**/*.spec.js' ],

    coffee: [ '<%= tmp_dir %>/**/*.coffee', '!<%= tmp_dir %>/**/*.spec.coffee' ],
    coffeeunit: [ '<%= tmp_dir %>/**/*.spec.coffee' ],

    app_tpl: [ '<%= tmp_dir %>/src/app/**/*.tpl.html' ],
    common_tpl: [ '<%= tmp_dir %>/src/common/**/*.tpl.html' ]
  },

  /**
   * This is a collection of files used during testing only.
   */
  test_files: {
    js: [
      'vendor/angular-mocks/angular-mocks.js'
    ]
  },

  /**
   * This is the same as `app_files`, except it contains patterns that
   * reference vendor code (`vendor/`) that we need to place into the build
   * process somewhere. While the `app_files` property ensures all
   * standardized files are collected for compilation, it is the user's job
   * to ensure non-standardized (i.e. vendor-related) files are handled
   * appropriately in `vendor_files.js`.
   *
   * The `vendor_files.js` property holds files to be automatically
   * concatenated and minified with our project source files.
   *
   * The `vendor_files.css` property holds any CSS files to be automatically
   * included in our app.
   *
   * The `vendor_files.assets` property holds any assets to be copied along
   * with our app's assets. This structure is flattened, so it is not
   * recommended that you use wildcards.
   */
  vendor_files: {
    js: [
      // independent libraries
      'vendor/jquery/dist/jquery.js',
      'vendor/moment/min/moment-with-locales.js',
      'vendor/lodash/dist/lodash.js',
      'vendor/hello/dist/hello.all.js',
      'vendor/cytoscape/dist/cytoscape.js',
      'vendor/raven-js/dist/raven.js',
      'vendor/sockjs-client/dist/sockjs.js',
      'vendor/centrifuge/centrifuge.js',
      'vendor/angular/angular.js',   // Angular lib should be the last of independent list!
      'vendor-offline/circletype/js/plugins.js',
      'vendor-offline/circletype/js/circletype.js',

      // Libraries depends on independent libraries
      'vendor/jquery-ui/ui/jquery-ui.js',

      'vendor/messageformat/messageformat.js',
      'vendor/messageformat/locale/en.js',
      'vendor/messageformat/locale/pl.js',

      'vendor/angular-animate/angular-animate.min.js',
      'vendor/angular-aria/angular-aria.min.js',
      'vendor/angular-lodash/angular-lodash.js',
      'vendor/angular-md5/angular-md5.js',
      'vendor/angular-moment/angular-moment.js',
      'vendor/angular-cookies/angular-cookies.js',
      'vendor/angular-sanitize/angular-sanitize.js',
      'vendor/angular-ui-utils/ui-utils.js',
      'vendor/angular-ui-router/release/angular-ui-router.js',
      'vendor/angular-ui-calendar/src/calendar.js',
      'vendor/angular-ui-select/dist/select.js',
      'vendor/angular-breadcrumb/dist/angular-breadcrumb.js',
      'vendor/fullcalendar/dist/fullcalendar.js',
      'vendor/fullcalendar/dist/lang/pl.js',
      'vendor/fullcalendar/dist/gcal.js',
      'vendor/angular-strap/dist/angular-strap.min.js',
      'vendor/angular-strap/dist/angular-strap.tpl.min.js',
      'vendor/angular-translate/angular-translate.js',
      'vendor/angular-translate-interpolation-messageformat/angular-translate-interpolation-messageformat.js',
      'vendor/angular-dynamic-locale/dist/tmhDynamicLocale.js',
      'vendor-offline/raven/raven-config.js',
      'vendor/angular-raven/angular-raven.js',
      'vendor/imagesloaded/imagesloaded.pkgd.js',

      'vendor/restangular/src/restangular.js',
      'vendor/underscore.string/dist/underscore.string.min.js',
      'vendor/angular-svg-round-progressbar/build/roundProgress.js',
      'vendor/bootstrap-sass-official/assets/javascripts/bootstrap.js',

      'vendor/ng-file-upload/ng-file-upload-shim.js',
      'vendor/ng-file-upload/ng-file-upload.js',

      'vendor/angular-audio/app/angular.audio.js',

      'vendor-offline/placeholders/angular-placeholders-0.0.1-SNAPSHOT.min.js',
      'vendor-offline/multidatespicker/jquery-ui.multidatespicker.js',
      'vendor-offline/authorization/routingConfig.js',
      'vendor-offline/hello/hello-config.js',

      // Edisonda JS files (from: build.config.js)
      // 'vendor/jquery/dist/jquery.min.js',

      // 'vendor/jquery-ui/jquery-ui.min.js', // Disabled because of lag
      // 'vendor/bootstrap-sass-official/assets/javascripts/bootstrap.min.js',

      'vendor-offline/edisonda/jquery.resize.js',                            // Offline
      'vendor/circles/circles.js',
      'vendor/dotdotdot/src/js/jquery.dotdotdot.js',
      'vendor/swiper/dist/js/swiper.jquery.js',

      'vendor/bootstrap-rating/bootstrap-rating.js',
      'vendor-offline/edisonda/jquery.style-form.js',                        // Offline
      'vendor/select2/dist/js/select2.js',
      'vendor/select2/dist/js/i18n/pl.js',
      'vendor/bootstrap-select/js/bootstrap-select.js',
      'vendor/jquery-placeholder/jquery.placeholder.js',
      'vendor-offline/edisonda/jquery.testpassword.js',                      // Offline
      'vendor/jquery-text-counter/textcounter.js',
      'vendor/tagmanager/tagmanager.js',
      'vendor/nanoscroller/bin/javascripts/jquery.nanoscroller.js',

      // In fact that we're using ng-file-upload, edisonda's blueimp is no more required
      // 'vendor/blueimp-tmpl/js/tmpl.js',
      // 'vendor/blueimp-load-image/js/load-image.all.min.js',
      // 'vendor/blueimp-canvas-to-blob/js/canvas-to-blob.js',
      // 'vendor/blueimp-gallery/js/blueimp-gallery.min.js',
      // 'vendor/blueimp-file-upload/js/jquery.iframe-transport.js',
      // 'vendor/blueimp-file-upload/js/jquery.fileupload.js',

      // 'vendor/blueimp-file-upload/js/jquery.fileupload-process.js',
      // 'vendor/blueimp-file-upload/js/jquery.fileupload-image.js',
      // 'vendor/blueimp-file-upload/js/jquery.fileupload-validate.js',
      // 'vendor/blueimp-file-upload/js/jquery.fileupload-ui.js',
      // 'vendor-offline/blueimp/blueimp-uploader-config.js',

      'vendor/jqplot-bower/dist/jquery.jqplot.js',
      'vendor/jqplot-bower/dist/plugins/jqplot.barRenderer.js',
      'vendor/jqplot-bower/dist/plugins/jqplot.canvasOverlay.js',
      'vendor/jqplot-bower/dist/plugins/jqplot.categoryAxisRenderer.js',
      'vendor/jqplot-bower/dist/plugins/jqplot.enhancedLegendRenderer.js',
      'vendor-offline/edisonda/dhtmlxScheduler_v4.3.1/codebase/dhtmlxscheduler.js',               // Offline
      'vendor-offline/edisonda/dhtmlxScheduler_v4.3.1/codebase/ext/dhtmlxscheduler_collision.js'  // Offline

      // Profitelo extended
      // 'vendor-offline/jqueryFileuploadForAngular/jqueryFileuploadForAngular.js'  // must be below jquery, angular and blueimp plugins
    ],

    // Includes external css libraries BEFORE other sass files
    css: [
      // EDISONDA addtitional CSS libs (from: build.config.js)
      'vendor/nanoscroller/bin/css/nanoscroller.css',
      'vendor/tagmanager/tagmanager.css',
      'vendor/select2/dist/css/select2.min.css',
      'vendor/bootstrap-select/dist/css/bootstrap-select.css',
      'vendor/swiper/dist/css/swiper.css',
      'vendor/angular-motion/dist/angular-motion.css',
      'vendor/bootstrap-rating/bootstrap-rating.css',
      'vendor/blueimp-file-upload/css/jquery.fileupload.css',
      'vendor/blueimp-file-upload/css/jquery.fileupload-ui.css',
      'vendor/jqplot-bower/dist/jquery.jqplot.css',
      'vendor/jquery-ui/themes/vader/jquery-ui.css',
      'vendor/jquery-ui/themes/vader/theme.css',
      'vendor-offline/dhtmlxScheduler_v4.3.1/codebase/dhtmlxscheduler.css', // Offline

      // Profitelo additional CSS libs
      'vendor/fullcalendar/dist/fullcalendar.css',
      'vendor/angular-ui-select/dist/select.css',
      'vendor-offline/selectize/selectize.default.css' // Find more: http://plnkr.co/edit/a3KlK8dKH3wwiiksDSn2?p=preview
    ],

    assets: [
    ]
  }
};
