permissionsConfig = require '../../../../common/permissionsConfig'

permissionsConfig.roles.forEach (value, i) ->
  Role.seed
    name:         value
    description:  value

