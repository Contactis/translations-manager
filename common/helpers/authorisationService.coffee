config  = require '../permissionsConfig'
jwt     = require 'jwt-simple'
moment  = require 'moment'

###
    Method to build a distinct bit mask for each role
    It starts off with "1" and shifts the bit to the left for each element in the
    roles array parameter
###

buildRoles = (roles) ->
  bitMask = '01'
  userRoles = {}
  for role of roles
    intCode = parseInt(bitMask, 2)
    userRoles[roles[role]] =
      bitMask: intCode
      title: roles[role]
    bitMask = (intCode << 1).toString(2)
  return userRoles

###
This method builds access level bit masks based on the accessLevelDeclaration parameter which must
contain an array for each access level containing the allowed user roles.
###

buildAccessLevels = (accessLevelDeclarations, userRoles) ->
  role          = null
  resultBitMask = null
  accessLevels = {}
  for level of accessLevelDeclarations
    if typeof accessLevelDeclarations[level] == 'string'
      if accessLevelDeclarations[level] == '*'
        resultBitMask = ''
        for role of userRoles
          resultBitMask += '1'
        #accessLevels[level] = parseInt(resultBitMask, 2);
        accessLevels[level] = bitMask: parseInt(resultBitMask, 2)
      else
        console.log 'Access Control Error: Could not parse \'' +
            accessLevelDeclarations[level] + '\' as access definition for level \'' + level + '\''
    else
      resultBitMask = 0
      for role of accessLevelDeclarations[level]
        if userRoles.hasOwnProperty(accessLevelDeclarations[level][role])
          resultBitMask = resultBitMask | userRoles[accessLevelDeclarations[level][role]].bitMask
        else
          console.log 'Access Control Error: Could not find role \'' +
              accessLevelDeclarations[level][role] + '\' in registered roles while building access for \'' +
              level + '\''
      accessLevels[level] = bitMask: resultBitMask
  return accessLevels

userRoles     = buildRoles config.roles
accessLevels  = buildAccessLevels config.accessLevels, userRoles

createNewToken = (userId) ->

  token = jwt.encode(userId, Math.random().toString(), 'HS512')

  orm.Sessions.create
    userId: userId
    token: token
    expiryAt: moment().add(7, 'days').format()


  return token



module.exports =
  userRoles:      userRoles
  accessLevels:   accessLevels
  createNewToken: createNewToken
