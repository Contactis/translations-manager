moment = require 'moment'

projectsLanguages = [
  {
    projectId:  1
    languageId: 1
  }
  {
    projectId:  1
    languageId: 3
  }
  {
    projectId:  2
    languageId: 1
  }
]

projectsLanguages.forEach (value, i) ->
  ProjectLanguage.seed value
