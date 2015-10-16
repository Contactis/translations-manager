moment = require 'moment'

translations = [
  {
    'translatedPhrase': 'Log in'
    'pluralForm': null
    'description': 'Action to enter into the system.'
    'translationsKeyId': 2
    'languageId': 1
    'statusId': 1
    'lastModifiedBy': 1
    'createdAt': moment().format()
    'updatedAt': moment().format()
  }
]

translations.forEach (value, i) ->
  Translation.seed value
