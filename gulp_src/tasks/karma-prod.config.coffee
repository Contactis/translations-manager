projectConfig = require '../variables'

# Karma starting point.
# Core settings used by every run type
module.exports = (config) ->
  config.set
    basePath: '/'
    frameworks: ['jasmine']
    plugins: [
      'karma-jasmine'
      'karma-coverage'
      'karma-mocha-reporter'
      'karma-junit-reporter'
      'karma-phantomjs-launcher'
      # 'karma-chrome-launcher'
      # 'karma-safari-launcher'
    ]
    reporters: [
      'mocha'
      'coverage'
      'junit'
    ]
    junitReporter:
      outputDir:  __dirname + '/../../' + projectConfig.build.gulp_build_dir + '/test-coverage/junit'
      suite:      ''
    coverageReporter:
      dir:        __dirname + '/../../' + projectConfig.build.gulp_build_dir + '/test-coverage'
      type:       'html'
    port:           9018
    runnerPort:     9100
    preprocessors:  {}
    urlRoot:        '/'
    colors:         true
    autoWatch:      true
    singleRun:      true
    browsers: [
      'PhantomJS'
      # 'Chrome'
      # 'Safari'
    ]
