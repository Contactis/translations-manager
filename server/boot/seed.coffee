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

    # Add roles for created users

    connectUserRole = (foundRoles, foundAccounts, roleName, accountId) ->
      roleResource = _.find(foundRoles, {name: roleName})
      roleResource.principals.create

        principalType: RoleMapping.USER
        principalId: accountId
      , ->
        if (++accountsProcessed == foundAccounts.length)
          process.exit()


    Account.find (err, foundAccounts) ->

      Role.find (arr, foundRoles) ->

        foundAccounts.forEach (val) ->

          connectUserRole foundRoles, foundAccounts, val.role, val.id

  return
