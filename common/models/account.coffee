authorisation = require '../helpers/authorisationService'
loopback = require 'loopback'

module.exports = (Account) ->
# make proper ACLs in the next version!
  require('../helpers/clearBaseACLs')(Account, require('./account.json'))

  Account.definition.properties.role.default = ->
    return 'user'

  Account.observe 'after save', (model, next) ->

    RoleMapping = loopback.RoleMapping
    Role        = loopback.Role

    # if Account doesn't have user role, add it to RoleMapping

    Role.findOne
      where:
        name: "user"
    , (err, responseRole) ->
        if !err
          RoleMapping.find
            where:
              roleId:       responseRole.id
              principalId:  model.instance.id
          , (err, response) ->
            if response.length == 0
              RoleMapping.create
                principalType: RoleMapping.USER
                roleId:       2
                principalId:  model.instance.id
              , (err, newRole)->
                  if !err
                    next()











