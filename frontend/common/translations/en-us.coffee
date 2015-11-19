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
    'TRANSLATION_MANAGER':        'Translation manager'
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
    'PAGE.TITLE.DASHBOARD':                                               'Dashboard'
    'PAGE.TITLE.TRANSLATOR':                                              'Translator'
    'PAGE.TITLE.PROGRAMMER':                                              'Programmer'
    'PAGE.TITLE.MANAGER':                                                 'Manager'
    'PAGE.TITLE.ADMINISTRATOR':                                           'Administrator'
    'PAGE.TITLE.ADMINISTRATOR.PROJECT_SETTINGS':                          'Project settings'


    # ### Backend messages


    # ## Frontend messages
    'APP.FRONTEND_MESSAGES.THIS_FEATURE_IS_NOT_YET_READY':
      'This feature is not yet ready. Apologize for any inconvenience.'

    # app/dashboard.jade


    # app/login.jade
    'EMAIL':                                        'E-mail'
    'PASSWORD':                                     'Password'
    'REPEAT_PASSWORD':                              'Repeat password'
    'FIRST_NAME':                                   'First name'
    'LAST_NAME':                                    'Last name'
    'REGISTER':                                     'Register'
    'COMPLETE':                                     'Complete'
    'REMEMBER_ME':                                  'Remember me'
    'LOGIN_WITH_YOUR_TRANSLATION_MANAGER_ACCOUNT':  'Login with your translation manager account'
    'USERNAME':                                     'Username'

    # app/admin/projectSettings.jade
    'APP.ADMIN.PROJECT_SETTINGS.SECTION_ABOUT':           'About'
    'APP.ADMIN.PROJECT_SETTINGS.SECTION_DATE_AND_TIME':   'Date & Time'
    'APP.ADMIN.PROJECT_SETTINGS.SECTION_WORKFLOW':        'Workflow'

    'APP.ADMIN.PROJECT_SETTINGS.FIELD_OUTPUT_CASE_TYPE_LABEL':  'Output Case type'

    'APP.ADMIN.PROJECT_SETTINGS.FIELD_NAMESPACE_LABEL':         'Separator for namespaces'
    'APP.ADMIN.PROJECT_SETTINGS.FIELD_NAMESPACE_PLACEHOLDER':   'Type a namespace separator character'
    'APP.ADMIN.PROJECT_SETTINGS.VALIDATION_NAMESPACE_REQUIRED':       'Namespace field is required'
    'APP.ADMIN.PROJECT_SETTINGS.VALIDATION_NAMESPACE_IS_NOT_VALID':   'Namespace field is not valid'
    'APP.ADMIN.PROJECT_SETTINGS.VALIDATION_NAMESPACE_IS_VALID':       'Namespace field is valid'
    'APP.ADMIN.PROJECT_SETTINGS.VALIDATION_NAMESPACE_MIN_CHARACTER':  'Namespace field must contain minimum 1 character'

    'APP.ADMIN.PROJECT_SETTINGS.FIELD_PROJECT_NAME_LABEL':
      'Project name'
    'APP.ADMIN.PROJECT_SETTINGS.FIELD_PROJECT_NAME_PLACEHOLDER':
      'Type short description about what is the project'
    'APP.ADMIN.PROJECT_SETTINGS.FIELD_PROJECT_DESCRITPION_LABEL':
      'Project description'
    'APP.ADMIN.PROJECT_SETTINGS.FIELD_PROJECT_DESCRITPION_PLACEHOLDER':
      'Type short description about what is the project'

    'APP.ADMIN.PROJECT_SETTINGS.SECTION_ABOUT_GENERAL_DESCRIPTION':
      'Nothing here yet'
    'APP.ADMIN.PROJECT_SETTINGS.SECTION_DATE_AND_TIME_GENERAL_DESCRIPTION':
      'Nothing here yet'
    'APP.ADMIN.PROJECT_SETTINGS.SECTION_WORKFLOW_GENERAL_DESCRIPTION':
      'All stuff related to building translations'

  })
])
