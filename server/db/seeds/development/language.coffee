moment = require 'moment'

languages = [
  {
    id:           1
    nameNative:   'English'
    nameEnglish:  'English'
    ietfCode:     'en'
    description:  'Internaltional'
  }
  {
    id:           2
    nameNative:   'Polski'
    nameEnglish:  'Polish'
    ietfCode:     'pl'
    description:  ''
  }
  {
    id:           3
    nameNative:   'Deutsch'
    nameEnglish:  'German'
    ietfCode:     'de'
    description:  ''
  }
  {
    id:           4
    nameNative:   'Portuguese'
    nameEnglish:  'português'
    ietfCode:     'pt'
    description:  ''
  }
  {
    id:           5
    nameNative:   'Nederlands'
    nameEnglish:  'Dutch'
    ietfCode:     'nl'
    description:  ''
  }
]

languages.forEach (value, i) ->
  Language.seed value
