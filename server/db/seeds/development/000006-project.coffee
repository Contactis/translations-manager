moment = require 'moment'

projects = [
  {
    id:               1
    name:             'Translation manager'
    prefixNamespace:  ''
    defaultLanguageId:  1
    description:      'This is dummy description for translation manager'
    createdAt:        moment().format()
    updatedAt:        moment().format()
  }
  {
    id:               2
    name:             'Sample project'
    prefixNamespace:  ''
    defaultLanguageId:  3
    description:      'The purpus of this project is to test the API'
    createdAt:        moment().format()
    updatedAt:        moment().format()
  }
]

projects.forEach (value, i) ->
  Project.seed value
