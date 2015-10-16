moment = require 'moment'

projectsUsers = [
  {
    userId:     1
    projectId:  1
  }
  {
    userId:     2
    projectId:  1
  }
  {
    userId:     4
    projectId:  1
  }
]

projectsUsers.forEach (value, i) ->
  ProjectUser.seed value
