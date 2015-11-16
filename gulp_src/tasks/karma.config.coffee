projectConfig = require '../variables'

# Karma starting point.
# Core settings used by every run type
module.exports = (config) ->
  config.set
    basePath: '/'
    preprocessors: 'coverage'
    frameworks: ['jasmine']
    plugins: [
      'karma-jasmine'
      'karma-coverage'
      'karma-mocha-reporter'
      'karma-phantomjs-launcher'
      'karma-chrome-launcher'
      'karma-safari-launcher'
      'karma-junit-reporter'
    ]
    reporters: [
      'mocha'
      'coverage'
      'junit'
    ]
    junitReporter:
      outputDir: __dirname + '/../../' + projectConfig.build.gulp_build_dir + '/test-coverage/junit'
      suite: ''

    port: 9018
    runnerPort: 9100
    preprocessors: {}
    urlRoot: '/'
    colors: true
    autoWatch: true
    singleRun: true
    browsers: [
      'PhantomJS'
    ]
    coverageReporter:
      type: 'html'
      dir:  __dirname + '/../../' + projectConfig.build.gulp_build_dir + '/test-coverage'
