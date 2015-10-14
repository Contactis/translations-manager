moment  = require 'moment'
chalk   = require 'chalk'
argv    = require('yargs').argv

module.exports = (server) ->

  if (typeof argv.disableCms is "undefined")
    cms = undefined
    try
      cms = require('isbx-loopback-cms')
    catch err
      console.log 'Run `npm install isbx-loopback-cms` to enable the ISBX CMS for LoopBack'
      return
    restApiRoot = server.get('restApiRoot')
    cmsApp = cms(server,
      basePath: restApiRoot
      modelPath: __dirname + '/../../common/models/'
      configPath: __dirname + '/../../CMS/config.json')
    server.use '/cms', cmsApp
    server.once 'started', ->
      baseUrl = server.get('url').replace(/\/$/, '')
      cmsPath = cmsApp.mountpath or cmsApp.route

      console.log "[#{chalk.gray moment().format 'HH:mm:ss'}]
      #{chalk.green '[CMS] Translation Manager CMS is running at'}
      #{chalk.blue 'http://' + baseUrl + cmsPath}"


    return
  return

