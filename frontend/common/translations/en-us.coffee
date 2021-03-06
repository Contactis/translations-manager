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
    'PROJECT.FULL_NAME':        'Translation manager'


    'GENERAL.PROJECT':                    'Project'
    'GENERAL.CHANGE_PROJECT':             'Change project'
    'GENERAL.LOGIN':                      'Login'
    'GENERAL.LOG_IN':                     'Log in'
    'GENERAL.LOG_OUT':                    'Log out'
    'GENERAL.SAVE':                       'Save'
    'GENERAL.SAVE_AND_CLOSE':             'Save and colose'
    'GENERAL.REMOVE':                     'Remove'
    'GENERAL.CREATE':                     'Create'
    'GENERAL.CANCEL':                     'Cancel'
    'GENERAL.CLEAN_FORM':                 'Clean form'
    'GENERAL.PENDING':                    'Pending'
    'GENERAL.LOADING':                    'Loading'
    'GENERAL.SETTINGS':                   'Settings'
    'GENERAL.MODIFY':                     'Modify'
    'GENERAL.VERIFIED':                   'Verified'
    'GENERAL.VERIFY':                     'Verify'
    'GENERAL.NOT_VERIFIED':               'Not verified'
    'GENERAL.DELETE':                     'Delete'
    'GENERAL.CLEAR':                     'Clear'
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
    'PAGE.404.TITLE':                               '404'
    'PAGE.LOGIN.TITLE':                             'Login'
    'PAGE.HELP.TITLE':                              'Help'
    'PAGE.DASHBOARD.TITLE':                         'Dashboard'
    'PAGE.TRANSLATOR.TITLE':                        'Translator view'
    'PAGE.PROGRAMMER.TITLE':                        'Programmer view'
    'PAGE.MANAGER.TITLE':                           'Manager view'
    'PAGE.PROJECT_MANAGEMENT.TITLE':                      'Project management'
    'PAGE.PROJECT_MANAGEMENT.NEW_PROJECT.TITLE':          'New project'
    'PAGE.PROJECT_MANAGEMENT.PROJECT_SETTINGS.TITLE':     'Project settings'
    'PAGE.PROJECT_MANAGEMENT.USER_ASSIGNMENT.TITLE':      'User assignment'
    'PAGE.PROJECT_MANAGEMENT.PROJECT_EXPORTER.TITLE':     'Project exporter'


    # ### Backend messages


    # ## Frontend messages
    'APP.FRONTEND_MESSAGES.THIS_FEATURE_IS_NOT_YET_READY':
      'This feature is not yet ready. Apologize for any inconvenience.'
    'APP.FRONTEND_MESSAGES.INFO':                                 'Info'
    'APP.FRONTEND_MESSAGES.SUCCESSFULLY_SAVED_THE_DATA':          'Successfully saved the data.'
    'APP.FRONTEND_MESSAGES.ERROR_OCCURED_WHILE_SAVING_THE_DATA':  'Error occured while saving the data.'
    'APP.FRONTEND_MESSAGES.ERROR_OCCURED_WHILE_GETTING_LANGUAGES_DATA':
      'Error occured while getting languages data.'
    'APP.FRONTEND_MESSAGES.TRY_AGAIN_LATER':                      'Try again later'

    'APP.FRONTEND_MESSAGES.WAITING_FOR_LOADING_DATA':   'Waiting for loading data'
    'APP.FRONTEND_MESSAGES.EXPECTED_PROVIDING_THE_FUNCTIONALITY_IS_@_MILESTONE':
      'Expected providing the functionality is for {{name}} milestone.'

    # authorization
    'APP.FRONTEND_MESSAGES.AUTHORIZATION.YOU_HAD_BEEN_LOGGED_OUT':
      'You had been logged out.'
    'APP.FRONTEND_MESSAGES.AUTHORIZATION.ACCESS_UNDEFINED_FOR_THIS_STATE':
      'Access undefined for this state'
    'APP.FRONTEND_MESSAGES.AUTHORIZATION.SEEMS_LIKE_YOU_DONT_HAVE_PERMISSIONS':
      'Seems like you don\'t have permissions to access that page.'

    # login
    'APP.FRONTEND_MESSAGES.LOGIN.WELCOME':                'Welcome!'
    'APP.FRONTEND_MESSAGES.LOGIN.REGISTRATION_ERROR':     'Registration error'
    'APP.FRONTEND_MESSAGES.LOGIN.LOGGING_ERROR':          'Logging error'
    'APP.FRONTEND_MESSAGES.LOGIN.PASSWORDS_DONT_MATCH':   'Passwords don\'t match. Try again'

    # userAssignment
    'APP.FRONTEND_MESSAGES.USER_ASSIGNMENT.REMOVED_ENTITIES_SUCCESSFULLY':
      'All related entities removed successfully'
    'APP.FRONTEND_MESSAGES.USER_ASSIGNMENT.REMOVED_ENTITIES_FAILED':
      'Removing entities failed'

    # programming-view
    'APP.FRONTEND_MESSAGES.PROGRAMMER_VIEW.LOADING_TRANSLATION_KEYS_FAILED':
      'Problem with loading translation keys'
    'APP.FRONTEND_MESSAGES.PROGRAMMER_VIEW.INDEX_KEY_NAME':           'Index key name'
    'APP.FRONTEND_MESSAGES.PROGRAMMER_VIEW.IS_PLURAL':                'Is plural'
    'APP.FRONTEND_MESSAGES.PROGRAMMER_VIEW.BASIC_TRANSLATION':        'Basic translation'
    'APP.FRONTEND_MESSAGES.PROGRAMMER_VIEW.CONTEXT_DESCRIPTION':      'Context description'
    'APP.FRONTEND_MESSAGES.PROGRAMMER_VIEW.ADD_NEW_TRANSLATION_KEY':  'Add new translation key'
    'APP.FRONTEND_MESSAGES.PROGRAMMER_VIEW.NO_INDEX_KEYS_AVAILABLE_FOR_CURRENT_PROJECT':
      'No index keys available for current project'
    'APP.FRONTEND_MESSAGES.PROGRAMMER_VIEW.ADD_NEW_INDEX_KEY':
      'Add new index key, to see results.'

    # project-exporter
    'APP.FRONTEND_MESSAGES.PROJECT_EXPORTER.SUCCESSFULLY_GENERATE_LIST' :  'Successfully generate list'

    # new project (view)
    'APP.FRONTEND_MESSAGES.NEW_PROJECT.PROJECT_REMOVED_SUCCESSFULLY' : 'Project removed successfully'
    'APP.FRONTEND_MESSAGES.NEW_PROJECT.ERROR_OCCURED_WHILE_REMOVING_PROJECT' : 'Error occured while removeing project'


    # dialog addNewProject
    'APP.FRONTEND_MESSAGES.ADD_NEW_PROJECT.PROJECT_CREATED_SUCCESSFULLY' :  'Project created successfully'
    'APP.FRONTEND_MESSAGES.ERROR_OCCURED_WHILE_GETTING_PROJECTS_DATA' :
      'Error occured while getting projects data'
    'APP.FRONTEND_MESSAGES.ADD_NEW_PROJECT.PROBLEM_OCCURED_WHILE_CREATING_NEW_PROJECT' :
      'Problem occured while creating new project'
    'APP.FRONTEND_MESSAGES.ADD_NEW_PROJECT.PROBLEM_OCCURED_WHILE_CREATING_PROJECT_LANGUAGE_ENTRY':
      'Problem occured while creating project-language entry'

    # ## dialogs

    # ### common/templates/dialog/translation.jade
    'COMMON.TEMPALTES.DIALOG.ADD_TRANSLATION_KEY_MODAL.ADD_NEW_TRANSLATION_KEY':
      'Add new translation key'
    'COMMON.TEMPALTES.DIALOG.ADD_TRANSLATION_KEY_MODAL.KEY_INDEX_TYPE':
      'Key index type'
    'COMMON.TEMPALTES.DIALOG.ADD_TRANSLATION_KEY_MODAL.STRING':
      'String'
    'COMMON.TEMPALTES.DIALOG.ADD_TRANSLATION_KEY_MODAL.PLURAL':
      'Plural'
    'COMMON.TEMPALTES.DIALOG.ADD_TRANSLATION_KEY_MODAL.PLURAL_FORMS':
      'Plural forms'
    'COMMON.TEMPALTES.DIALOG.ADD_TRANSLATION_KEY_MODAL.NAMESPACE':
      'Namespace'
    'COMMON.TEMPALTES.DIALOG.ADD_TRANSLATION_KEY_MODAL.KEY_INDEX':
      'Key index'
    'COMMON.TEMPALTES.DIALOG.ADD_TRANSLATION_KEY_MODAL.DEFAULT_TRANSLATION':
      'Default translation'
    'COMMON.TEMPALTES.DIALOG.ADD_TRANSLATION_KEY_MODAL.LIVE_PREVIEW_RESULT':
      'Live preview result'
    'COMMON.TEMPALTES.DIALOG.ADD_TRANSLATION_KEY_MODAL.CONTEXT_DESCRIPTION':
      'Context description'



    # common/templates/dialog/addNewProject.jade
    'COMMON.TEMPALTES.DIALOG.ADD_NEW_PROJECT.ADD_NEW_PROJECT': 'Add new project'
    'COMMON.TEMPALTES.DIALOG.ADD_NEW_PROJECT.PROJECT_NAME': 'Project name'
    'COMMON.TEMPALTES.DIALOG.ADD_NEW_PROJECT.PROJECT_NAME_PLACEHOLDER': 'ex: Supersonic cars'
    'COMMON.TEMPALTES.DIALOG.ADD_NEW_PROJECT.PROJECT_NAMESPACE':
      'Project namespace'
    'COMMON.TEMPALTES.DIALOG.ADD_NEW_PROJECT.PROJECT_NAMESPACE_PLACEHOLDER':
      'This prefix will be pasted before each one key-index\'s namespace for this project'
    'COMMON.TEMPALTES.DIALOG.ADD_NEW_PROJECT.PROJECT_DESCRIPTION': 'Project description'
    'COMMON.TEMPALTES.DIALOG.ADD_NEW_PROJECT.PROJECT_DESCRIPTION_PLACEHOLDER':
      'Simple description better describing this project'
    'COMMON.TEMPALTES.DIALOG.ADD_NEW_PROJECT.DEFAULT_LANGUAGE' : 'Default language'
    'COMMON.TEMPALTES.DIALOG.ADD_NEW_PROJECT.SELECT_LANGUAGE': '<< Select a language >>'
    'COMMON.TEMPALTES.DIALOG.ADD_NEW_PROJECT.VALIDATION.PROJECT_NAME_REQUIRED':
      'Project name required'
    'COMMON.TEMPALTES.DIALOG.ADD_NEW_PROJECT.VALIDATION.PROJECT_DEFAULT_LANGUAGE_REQUIRED' :
      'Project default language required'

    # ## app/dashboard.jade

    # ## app/login.jade
    'APP.LOGIN.SING_IN':                                      'Sing in'
    'APP.LOGIN.REGISTER':                                     'Register'
    'APP.LOGIN.EMAIL':                                        'E-mail'
    'APP.LOGIN.PASSWORD':                                     'Password'
    'APP.LOGIN.REPEAT_PASSWORD':                              'Repeat password'
    'APP.LOGIN.FIRST_NAME':                                   'First name'
    'APP.LOGIN.LAST_NAME':                                    'Last name'
    'APP.LOGIN.REGISTER':                                     'Register'
    'APP.LOGIN.COMPLETE':                                     'Complete'
    'APP.LOGIN.REMEMBER_ME':                                  'Remember me'
    'APP.LOGIN.LOGIN_WITH_YOUR_TRANSLATION_MANAGER_ACCOUNT':  'Login with your translation manager account'
    'APP.LOGIN.USERNAME':                                     'Username'


    # ## app/project-manager/programmer-view/programmer-view.coffee
    'APP.PROJECT_MANAGER.PROGRAMMER_VIEW.':     'Nothing yet'


    # ## app/project-manager/admin/userAssignment.jade
    'APP.ADMIN.USER_ASSIGNMENT.GENETAL_DESCRIPTION':     'Nothing yet'

    'APP.ADMIN.USER_ASSIGNMENT.SECTION_PROJECT_USERS':   'Project users'
    'APP.ADMIN.USER_ASSIGNMENT.SECTION_PROJECT_USERS_GENERAL_DESCRIPTION':
      'Nothing yet'
    'APP.ADMIN.USER_ASSIGNMENT.SECTION_PROJECT_USERS.AVAILABLE_USERS': 'Available users'
    'APP.ADMIN.USER_ASSIGNMENT.SECTION_PROJECT_USERS.ASSIGNED_USERS':  'Assigned Users'


    # ## app/project-manager/admin/projectExporter.jade
    'APP.ADMIN.PROJECT_EXPORTER.TITLE':                            'Project Exporter'
    'APP.ADMIN.PROJECT_EXPORTER.GENETAL_DESCRIPTION':              'Nothing here yet'
    'APP.ADMIN.PROJECT_EXPORTER.EXPORTER.TITLE':                   'Exporter'
    'APP.ADMIN.PROJECT_EXPORTER.EXPORTER.GENETAL_DESCRIPTION':     'Nothing here yet'
    'APP.ADMIN.PROJECT_EXPORTER.EXPORTER.WHICH_LANGUAGE_EXPORT': \
      'Which language you want to export for current project',

    # ## 2app/project-manager/admin/newProject/newProject.jade
    'APP.ADMIN.NEW_PROJECT.TITLE': 'Add new project',
    'APP.ADMIN.NEW_PROJECT.GENETAL_DESCRIPTION': 'Manage of adding or removing projects'
    'APP.ADMIN.NEW_PROJECT.FRONTEND_MESSAGES.NO_PROJECTS_AVAILABLE': 'No projects available',
    'APP.ADMIN.NEW_PROJECT.FRONTEND_MESSAGES.ADD_NEW_PROJECT': 'Add new project'
    'APP.ADMIN.NEW_PROJECT.TABLE.ID': 'Id'
    'APP.ADMIN.NEW_PROJECT.TABLE.PROJECT_NAME': 'Project name'
    'APP.ADMIN.NEW_PROJECT.TABLE.PROJECT_DESCRIPTION': 'Project description'
    'APP.ADMIN.NEW_PROJECT.TABLE.PREFIX_NAMESPACE': 'Prefix namespace'
    'APP.ADMIN.NEW_PROJECT.TABLE.DEFAULT_LANGUAGE': 'Default language'
    'APP.ADMIN.NEW_PROJECT.TABLE.DELETE_PROJECT': 'Delete project'
    'APP.ADMIN.NEW_PROJECT.DELETE': 'Delete'

    # ## app/project-manager/admin/projectSettings.jade
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
    'APP.ADMIN.PROJECT_SETTINGS.FIELD_PROJECT_PREFIX_NAMESPACE_LABEL':         'Prefix namespace'
    'APP.ADMIN.PROJECT_SETTINGS.FIELD_PROJECT_PREFIX_NAMESPACE_PLACEHOLDER':
      'This prefix will be pasted before each one key-index\'s namespace for this project'
    'APP.ADMIN.PROJECT_SETTINGS.FIELD_PROJECT_DEFAULT_LANGUAGE_LABEL':    'Project default language'
    'APP.ADMIN.PROJECT_SETTINGS.FIELD_PROJECT_DEFAULT_LANGUAGE_PLACEHOLDER':
      'Select or search default language for the project'

    'APP.ADMIN.PROJECT_SETTINGS.SECTION_ABOUT_GENERAL_DESCRIPTION':         'Nothing here yet'
    'APP.ADMIN.PROJECT_SETTINGS.SECTION_DATE_AND_TIME_GENERAL_DESCRIPTION': 'Nothing here yet'
    'APP.ADMIN.PROJECT_SETTINGS.SECTION_WORKFLOW_GENERAL_DESCRIPTION':
      'All stuff related to building translations'


    # app/project-manager/admin/userAssignment.jade
    'APP.ADMIN.USER_ASSIGNMENT.GENETAL_DESCRIPTION':     'Nothing yet'

    'APP.ADMIN.USER_ASSIGNMENT.SECTION_PROJECT_USERS':   'Project users'
    'APP.ADMIN.USER_ASSIGNMENT.SECTION_PROJECT_USERS_GENERAL_DESCRIPTION':
      'Nothing yet'
    'APP.ADMIN.USER_ASSIGNMENT.SECTION_PROJECT_USERS.AVAILABLE_USERS': 'Available users'
    'APP.ADMIN.USER_ASSIGNMENT.SECTION_PROJECT_USERS.ASSIGNED_USERS':  'Assigned Users'

    # common/directives/trWaitingSpinnerDiv/trWaitingSpinnerDiv.jade
  })
])
