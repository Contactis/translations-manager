moment = require 'moment'

translationsStatuses = [
  {
    name:         "to_verify"
    description:  "Waiting for verification by translator"
  }
  {
    name:       "to_accept"
    pluralForm: "Waiting for acceptation by manager"
  }
  {
    name:       "accepted"
    pluralForm: "Accepted"
  }
  {
    name:       "rejected"
    pluralForm: "Rejected"
  }
]

translationsStatuses.forEach (value, i) ->
  TranslationStatus.seed value
