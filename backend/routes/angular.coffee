path = require 'path'

app.all '/*', (req, res) ->
  res.sendFile path.resolve __dirname + '/../../public/index.html'
