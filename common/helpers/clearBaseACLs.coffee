module.exports = (ModelType, ModelConfig) ->
  ModelType.settings.acls.length = 0
  ModelConfig.acls.forEach (r) ->
    ModelType.settings.acls.push r
    return
  return

