path = require 'path'

app.get '/', (req, res) ->
  res.sendFile path.resolve __dirname + '/../../public/index.html'
