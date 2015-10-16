argv  = require('yargs').argv
_     = require 'lodash'

module.exports = (server) ->

  if (typeof argv.kill is not "undefined") or (argv.kill is true)
    setTimeout ->
      process.exit()
    , 1000

  if (typeof argv.seeds is not "undefined") or (argv.seeds is true)

    server.seed()


  if (typeof argv.secondarySeeds is not "undefined") or (argv.secondarySeeds is true)

    Account     = server.models.Account
    Role        = server.models.Role
    RoleMapping = server.models.RoleMapping

    accountsProcessed = 0
    otherAccountRole = []

    # Add roles for created users

    connectUserRole = (foundRoles, otherAccountRole, roleName, accountId) ->
      roleResource = _.find foundRoles, {name: roleName}
      roleResource.principals.create

        principalType: RoleMapping.USER
        principalId: accountId
      , ->
        if (++accountsProcessed == otherAccountRole.length)
          process.exit()


    Account.find (err, foundAccounts) ->

      otherAccountRole = _.reject foundAccounts, (value) ->
        return value.role == 'user'

      Role.find (arr, foundRoles) ->

        otherAccountRole.forEach (val) ->
          if val.role != 'user'
            connectUserRole foundRoles, otherAccountRole, val.role, val.id

  return
