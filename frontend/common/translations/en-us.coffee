# Translation en-US
# =================
translationApp.config( [
  '$translateProvider'
($translateProvider) ->

  $translateProvider.translations('en-us', {
    # ## Pluralizations
    # **Pluralization** according to current language.
    # More info on how to translate (what formats are available for current language) you'll find in
    # [THIS WEBSITE](http://unicode.org/repos/cldr-tmp/trunk/diff/supplemental/language_plural_rules.html)

    # If nothing set it'll show default strings in HTML templates


    # ### Common phrases
    # This section contains general phrases used in project
    'LOGIN':                      'Login'
    'LOG_IN':                     'Log in'
    'LOG_OUT':                    'Log out'
    'SAVE':                       'Save'
    'SAVE_AND_CLOSE':             'Save and colose'
    'REMOVE':                     'Remove'
    'CANCEL':                     'Cancel'
    'PENDING':                    'Pending'
    'LOADING':                    'Loading'
    'WAITING_FOR_LOADING_DATA':   'Waiting for loading data'
    'SETTINGS':                   'Settings'
    'VERIFIED':                   'Verified'
    'VERIFY':                     'Verify'
    'NOT_VERIFIED':               'Not verified'
    'REMOVE':                     'Remove'
    'DELETE':                     'Delete'
    'YES':                        'Yes'
    'NO':                         'No'
    'TRY_AGAIN':                  'Try again'
    'USER_UNKNOWN':               'User unknown'
    'CHANGE':                     'Change'
    'SAVE_CHANGES':               'Save changes'
    'NOT_DEFINED':                'Not defined'
    'NAME_NOT_DEFINED':           'Name not defined'
    'EDIT':                       'Edit'


    # ### Page naming
    'PAGE.TITLE.404':                                                     '404'
    'PAGE.TITLE.LOGIN':                                                   'Login'
    'PAGE.TITLE.HELP':                                                    'Help'
    'PAGE.TITLE.PROGRAMMER':                                              'Programmer'
    'PAGE.TITLE.MANAGER':                                                 'Manager'
    'PAGE.TITLE.TRANSLATOR':                                              'Translator'
    'PAGE.TITLE.ADMINISTRATOR':                                           'Administrator'
    'PAGE.TITLE.DASHBOARD':                                               'Dashboard'


    # ### Backend messages


    # ## Frontend messages


    # app/dashboard.jade


    # app/login.jade
    'LOGIN_WITH_YOUR_TRANSLATION_MANAGER_ACCOUNT':  'Login with your translation manager account'

  })
])
