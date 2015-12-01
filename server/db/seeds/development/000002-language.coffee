moment = require 'moment'

languages = [
  {
    id:           1
    nameNative:   'English'
    nameEnglish:  'English'
    ietfCode:     'en'
    description:  'Internaltional version of English'
  }
  {
    id:           2
    nameNative:   'American English'
    nameEnglish:  'English U.S.'
    ietfCode:     'en-us'
    description:  'Internaltional version of English'
  }
  {
    id:           3
    nameNative:   'Polski'
    nameEnglish:  'Polish'
    ietfCode:     'pl-pl'
    description:  ''
  }
  {
    id:           4
    nameNative:   'Deutsch'
    nameEnglish:  'German'
    ietfCode:     'de-de'
    description:  ''
  }
  {
    id:           5
    nameNative:   'Português'
    nameEnglish:  'Portuguese'
    ietfCode:     'pt'
    description:  ''
  }
  {
    id:           6
    nameNative:   'Dutch'
    nameEnglish:  'Nederlands'
    ietfCode:     'nl'
    description:  ''
  }
]

languages.forEach (value, i) ->
  Language.seed value
