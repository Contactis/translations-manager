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
    'GENERAL.LOGIN':                      'Login'
    'GENERAL.LOG_IN':                     'Log in'
    'GENERAL.LOG_OUT':                    'Log out'
    'GENERAL.SAVE':                       'Save'
    'GENERAL.SAVE_AND_CLOSE':             'Save and colose'
    'GENERAL.REMOVE':                     'Remove'
    'GENERAL.CANCEL':                     'Cancel'
    'GENERAL.PENDING':                    'Pending'
    'GENERAL.LOADING':                    'Loading'
    'GENERAL.SETTINGS':                   'Settings'
    'GENERAL.VERIFIED':                   'Verified'
    'GENERAL.VERIFY':                     'Verify'
    'GENERAL.NOT_VERIFIED':               'Not verified'
    'GENERAL.DELETE':                     'Delete'
    'GENERAL.YES':                        'Yes'
    'GENERAL.NO':                         'No'
    'GENERAL.TRY_AGAIN':                  'Try again'
    'GENERAL.USER_UNKNOWN':               'User unknown'
    'GENERAL.CHANGE':                     'Change'
    'GENERAL.SAVE_CHANGES':               'Save changes'
    'GENERAL.NOT_DEFINED':                'Not defined'
    'GENERAL.NAME_NOT_DEFINED':           'Name not defined'
    'GENERAL.EDIT':                       'Edit'


    # ### Page naming
    'PAGE.TITLE.404':                               '404'
    'PAGE.TITLE.LOGIN':                             'Login'
    'PAGE.TITLE.HELP':                              'Help'
    'PAGE.TITLE.DASHBOARD':                         'Dashboard'
    'PAGE.TITLE.TRANSLATOR':                        'Translator'
    'PAGE.TITLE.PROGRAMMER':                        'Programmer'
    'PAGE.TITLE.MANAGER':                           'Manager'
    'PAGE.TITLE.ADMINISTRATOR':                     'Administrator'
    'PAGE.TITLE.ADMINISTRATOR.PROJECT_SETTINGS':    'Project settings'
    'PAGE.TITLE.ADMINISTRATOR.USER_ASSIGNMENT':     'User assignment'


    # ### Backend messages


    # ## Frontend messages
    'APP.FRONTEND_MESSAGES.THIS_FEATURE_IS_NOT_YET_READY':
      'This feature is not yet ready. Apologize for any inconvenience.'
    'APP.FRONTEND_MESSAGES.INFO':                                 'Info'
    'APP.FRONTEND_MESSAGES.SUCCESSFULLY_SAVED_THE_DATA':          'Successfully saved the data.'
    'APP.FRONTEND_MESSAGES.ERROR_OCCURED_WHILE_SAVING_THE_DATA':  'Error occured while saving the data.'
    'APP.FRONTEND_MESSAGES.TRY_AGAIN_LATER':                      'Try again later'

    'APP.FRONTEND_MESSAGES.WAITING_FOR_LOADING_DATA':   'Waiting for loading data'

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


    # app/project-manager/admin/userAssignment.jade
    'APP.ADMIN.USER_ASSIGNMENT.GENETAL_DESCRIPTION':     'Nothing yet'

    'APP.ADMIN.USER_ASSIGNMENT.SECTION_PROJECT_USERS':   'Project users'
    'APP.ADMIN.USER_ASSIGNMENT.SECTION_PROJECT_USERS_GENERAL_DESCRIPTION':
      'Nothing yet'
    'APP.ADMIN.USER_ASSIGNMENT.SECTION_PROJECT_USERS.AVAILABLE_USERS': 'Available users'
    'APP.ADMIN.USER_ASSIGNMENT.SECTION_PROJECT_USERS.ASSIGNED_USERS':  'Assigned Users'


    # app/project-manager/admin/projectSettings.jade
    'APP.ADMIN.PROJECT_SETTINGS.GENETAL_DESCRIPTION':     'Nothing here yet'

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

    'APP.ADMIN.PROJECT_SETTINGS.FIELD_PROJECT_NAME_LABEL':                'Project name'
    'APP.ADMIN.PROJECT_SETTINGS.FIELD_PROJECT_NAME_PLACEHOLDER':          'Type name for the project'
    'APP.ADMIN.PROJECT_SETTINGS.FIELD_PROJECT_DESCRITPION_LABEL':         'Project description'
    'APP.ADMIN.PROJECT_SETTINGS.FIELD_PROJECT_DESCRITPION_PLACEHOLDER':
      'Type short description about what is the project'
    'APP.ADMIN.PROJECT_SETTINGS.FIELD_PROJECT_DEFAULT_LANGUAGE_LABEL':    'Project default language'
    'APP.ADMIN.PROJECT_SETTINGS.FIELD_PROJECT_DEFAULT_LANGUAGE_PLACEHOLDER':
      'Select or search default language for the project'

    'APP.ADMIN.PROJECT_SETTINGS.SECTION_ABOUT_GENERAL_DESCRIPTION':         'Nothing here yet'
    'APP.ADMIN.PROJECT_SETTINGS.SECTION_DATE_AND_TIME_GENERAL_DESCRIPTION': 'Nothing here yet'
    'APP.ADMIN.PROJECT_SETTINGS.SECTION_WORKFLOW_GENERAL_DESCRIPTION':
      'All stuff related to building translations'

  })
])
