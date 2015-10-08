module.exports = (app) ->
  app.dataSources.sqlite.isActual (err, actual) ->
    if !actual
      app.dataSources.sqlite.autoupdate()
    return
  return
