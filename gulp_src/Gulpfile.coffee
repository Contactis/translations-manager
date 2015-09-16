require('fs').readdirSync(__dirname + '/tasks').forEach (val) ->
  require "./tasks/#{val}"