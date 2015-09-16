models = [
  require './languages'
  require './languageTranslations'
]

require '../bootstrap/associations'

models.forEach (val) ->
  orm[val.model].truncate().then ->
    orm[val.model].bulkCreate val.data
