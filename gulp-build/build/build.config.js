module.exports = {
  backendDir: 'backend',
  frontendDir: 'frontend',
  tpl_name: 'templates-module.js',
  tpl_module: 'templates-module',
  gulp_build_dir: 'gulp-build',
  project_theme_name: 'theme_material',
  vendor_files: {
    js: 'frontend/vendor/jquery/dist/jquery.js',
    assets: '',
    css: ['frontend/vendor/fullcalendar/dist/fullcalendar.css']
  },
  app_files: {
    coffee: ['frontend/**/*.coffee', '!frontend/**/*.spec.coffee'],
    all_coffee: 'frontend/**/*.coffee',
    gulp_files: 'gulp/**/*.coffee',
    git_commit: 'src/assets/gitcommit.js',
    jade_app_tpl: 'frontend/app/**/*.jade',
    jade_common_tpl: 'frontend/common/**/*.jade',
    jade_all_templates: 'frontend/**/*.jade',
    assets: ['frontend/assets/**'],
    html: ['frontend/index.html'],
    less: ['frontend/less/main.less'],
    sass: ['frontend/sass/main.sass']
  },
  test_files: {
    js: 'vendor/angular-mocks/angular-mocks.js'
  }
};
