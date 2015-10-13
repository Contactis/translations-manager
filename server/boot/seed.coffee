argv  = require('yargs').argv

module.exports = (server) ->

  if (typeof argv.kill is not "undefined") or (argv.kill is true)
    setTimeout ->
      process.exit()
    , 1000

  if (typeof argv.seeds is not "undefined") or (argv.seeds is true)

    server.seed()




  return
