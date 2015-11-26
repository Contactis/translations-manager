moment = require 'moment'

translationsKeys = [
  {
    'keyString': 'LOGIN'
    'isPlural': false
    'projectId': 1
    'namespaceId': 3
  }
  {
    'keyString': 'LOG_IN'
    'isPlural': false
    'projectId': 1
    'namespaceId': 5
  }
  {
    'keyString': 'LOG_OUT'
    'isPlural': false
    'projectId': 1
    'namespaceId': 4
  }
  {
    'keyString': 'SAVE'
    'isPlural': false
    'projectId': 1
    'namespaceId': 4
  }
  {
    'keyString': 'SAVE_AND_CLOSE'
    'isPlural': false
    'projectId': 1
    'namespaceId': 5
  }
  {
    'keyString': 'INCOME'
    'isPlural': false
    'projectId': 1
    'namespaceId': 5
  }
  {
    'keyString': 'WITHDRAW'
    'isPlural': false
    'projectId': 1
    'namespaceId': 4
  }
  {
    'keyString': 'RECHARGE'
    'isPlural': false
    'projectId': 1
    'namespaceId': 1
  }
  {
    'keyString': 'ADD_NEW_SERVICE'
    'isPlural': false
    'projectId': 1
    'namespaceId': 1
  }
  {
    'keyString': 'ADD'
    'isPlural': false
    'projectId': 1
    'namespaceId': 3
  }
  {
    'keyString': 'REMOVE'
    'isPlural': false
    'projectId': 1
    'namespaceId': 3
  }
#  {
#    'keyString': 'CANCEL'
#    'isPlural': false
#    'projectId': 1
#    'namespaceId': 1
#  }
#  {
#    'keyString': 'PENDING'
#    'isPlural': false
#    'projectId': 1
#    'namespaceId': 2
#  }
#  {
#    'keyString': 'LOADING'
#    'isPlural': false
#    'projectId': 1
#    'namespaceId': 5
#  }
#  {
#    'keyString': 'WAITING_FOR_LOADING_DATA'
#    'isPlural': false
#    'projectId': 1
#    'namespaceId': 1
#  }
#  {
#    'keyString': 'SETTINGS'
#    'isPlural': false
#    'projectId': 1
#    'namespaceId': 3
#  }
#  {
#    'keyString': 'VERIFIED'
#    'isPlural': false
#    'projectId': 1
#    'namespaceId': 1
#  }
#  {
#    'keyString': 'VERIFY'
#    'isPlural': false
#    'projectId': 1
#    'namespaceId': 2
#  }
#  {
#    'keyString': 'NOT_VERIFIED'
#    'isPlural': false
#    'projectId': 1
#    'namespaceId': 5
#  }
#  {
#    'keyString': 'DELETE'
#    'isPlural': false
#    'projectId': 1
#    'namespaceId': 3
#  }
#  {
#    'keyString': 'DETACH'
#    'isPlural': false
#    'projectId': 1
#    'namespaceId': 4
#  }
#  {
#    'keyString': 'YES'
#    'isPlural': false
#    'projectId': 1
#    'namespaceId': 1
#  }
#  {
#    'keyString': 'NO'
#    'isPlural': false
#    'projectId': 1
#    'namespaceId': 5
#  }
#  {
#    'keyString': 'BROWSE_FILE'
#    'isPlural': false
#    'projectId': 1
#    'namespaceId': 2
#  }
#  {
#    'keyString': 'BROWSE_FILES'
#    'isPlural': false
#    'projectId': 1
#    'namespaceId': 1
#  }
#  {
#    'keyString': 'FINISH'
#    'isPlural': false
#    'projectId': 1
#    'namespaceId': 1
#  }
#  {
#    'keyString': 'OTHER'
#    'isPlural': false
#    'projectId': 1
#    'namespaceId': 4
#  }
#  {
#    'keyString': 'TRY_AGAIN'
#    'isPlural': false
#    'projectId': 1
#    'namespaceId': 5
#  }
#  {
#    'keyString': 'USER_UNKNOWN'
#    'isPlural': false
#    'projectId': 1
#    'namespaceId': 5
#  }
#  {
#    'keyString': 'LANG_ENGLISH'
#    'isPlural': false
#    'projectId': 1
#    'namespaceId': 2
#  }
#  {
#    'keyString': 'LANG_POLISH'
#    'isPlural': false
#    'projectId': 1
#    'namespaceId': 4
#  }
#  {
#    'keyString': 'CHANGE'
#    'isPlural': false
#    'projectId': 1
#    'namespaceId': 5
#  }
#  {
#    'keyString': 'SAVE_CHANGES'
#    'isPlural': false
#    'projectId': 1
#    'namespaceId': 5
#  }
#  {
#    'keyString': 'NOT_DEFINED'
#    'isPlural': false
#    'projectId': 1
#    'namespaceId': 2
#  }
#  {
#    'keyString': 'NAME_NOT_DEFINED'
#    'isPlural': false
#    'projectId': 1
#    'namespaceId': 2
#  }
#  {
#    'keyString': 'SERVICE_NAME_IS_NOT_DEFINED'
#    'isPlural': false
#    'projectId': 1
#    'namespaceId': 4
#  }
#  {
#    'keyString': 'PRICE'
#    'isPlural': false
#    'projectId': 1
#    'namespaceId': 3
#  }
#  {
#    'keyString': 'TELEPHONE_SHORTCUT'
#    'isPlural': false
#    'projectId': 1
#    'namespaceId': 3
#  }
#  {
#    'keyString': 'OPTIONAL'
#    'isPlural': false
#    'projectId': 1
#    'namespaceId': 4
#  }
#  {
#    'keyString': 'FILE_NAME_NOT_PROVIDED'
#    'isPlural': false
#    'projectId': 1
#    'namespaceId': 5
#  }
#  {
#    'keyString': 'RETURN'
#    'isPlural': false
#    'projectId': 1
#    'namespaceId': 3
#  }
#  {
#    'keyString': 'SEND'
#    'isPlural': false
#    'projectId': 1
#    'namespaceId': 1
#  }
#  {
#    'keyString': 'EXPERTS'
#    'isPlural': false
#    'projectId': 1
#    'namespaceId': 3
#  }
#  {
#    'keyString': 'BALANCE'
#    'isPlural': false
#    'projectId': 1
#    'namespaceId': 2
#  }
#  {
#    'keyString': 'NET_AMOUNT'
#    'isPlural': false
#    'projectId': 1
#    'namespaceId': 5
#  }
#  {
#    'keyString': 'PAYMENTS'
#    'isPlural': false
#    'projectId': 1
#    'namespaceId': 4
#  }
#  {
#    'keyString': 'WITHDRAWS'
#    'isPlural': false
#    'projectId': 1
#    'namespaceId': 4
#  }
#  {
#    'keyString': 'SELECT'
#    'isPlural': false
#    'projectId': 1
#    'namespaceId': 4
#  }
#  {
#    'keyString': 'NET'
#    'isPlural': false
#    'projectId': 1
#    'namespaceId': 1
#  }
#  {
#    'keyString': 'EDIT'
#    'isPlural': false
#    'projectId': 1
#    'namespaceId': 2
#  }
]

translationsKeys.forEach (value, i) ->
  TranslationKey.seed value
