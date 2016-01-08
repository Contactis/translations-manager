module.exports = (app) ->
  app.dataSources.mysql.isActual (err, actual) ->
    if !actual
      app.dataSources.mysql.autoupdate()
    return
  return
