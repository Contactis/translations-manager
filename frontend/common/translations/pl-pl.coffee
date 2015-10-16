# Translation en-US
# =================
translationApp.config( [
  '$translateProvider'
($translateProvider) ->

  $translateProvider.translations('pl-pl', {
    # ## Pluralizations
    # **Pluralization** according to current language.
    # More info on how to translate (what formats are available for current language) you'll find in
    # [THIS WEBSITE](http://unicode.org/repos/cldr-tmp/trunk/diff/supplemental/language_plural_rules.html)

    # If nothing set it'll show default strings in HTML templates


    # ### Common phrases
    # This section contains general phrases used in project
    'TRANSLATION_MANAGER':        'Menadżer tłumaczeń'
    'LOGIN':                      'Login'
    'LOG_IN':                     'Zaloguj się'
    'LOG_OUT':                    'Wyloguj się'
    'SAVE':                       'Zapisz'
    'SAVE_AND_CLOSE':             'Zapisz i zamknij'
    'REMOVE':                     'Usuń'
    'CANCEL':                     'Anuluj'
    'PENDING':                    'w oczekiwaniu'
    'LOADING':                    'Wczytywanie'
    'WAITING_FOR_LOADING_DATA':   'Oczekiwanie na załadowanie danych'
    'SETTINGS':                   'Ustawienia'
    'VERIFIED':                   'Zweryfikowany'
    'VERIFY':                     'Weryfikuj'
    'NOT_VERIFIED':               'Niezweryfikowany'
    'DELETE':                     'Wymaż'
    'YES':                        'Tak'
    'NO':                         'Nie'
    'TRY_AGAIN':                  'Spróbuj ponownie'
    'USER_UNKNOWN':               'Użytkownik nieznany'
    'CHANGE':                     'Zmień'
    'SAVE_CHANGES':               'Zapisz zmiany'
    'NOT_DEFINED':                'Niezdefiniowany'
    'NAME_NOT_DEFINED':           'Nazwa nie zdefiniowana'
    'EDIT':                       'Edytuj'


    # ### Page naming
    'PAGE.TITLE.404':                                                     '404'
    'PAGE.TITLE.LOGIN':                                                   'Logowanie'
    'PAGE.TITLE.HELP':                                                    'Pomoc'
    'PAGE.TITLE.PROGRAMMER':                                              'Programista'
    'PAGE.TITLE.MANAGER':                                                 'Menadżer'
    'PAGE.TITLE.TRANSLATOR':                                              'Tłumacz'
    'PAGE.TITLE.ADMINISTRATOR':                                           'Administrator'
    'PAGE.TITLE.DASHBOARD':                                               'Dashboard'


    # ### Backend messages


    # ## Frontend messages


    # app/dashboard.jade


    # app/login.jade
    # ### login.jade
    'EMAIL':                                        'E-mail'
    'PASSWORD':                                     'Hasło'
    'REPEAT_PASSWORD':                              'Powtórz hasło'
    'FIRST_NAME':                                   'Imię'
    'LAST_NAME':                                    'Nazwisko'
    'REGISTER':                                     'Zarejestruj'
    'COMPLETE':                                     'Zakończ'
    'REMEMBER_ME':                                  'Pamiętaj mnie'
    'LOGIN_WITH_YOUR_TRANSLATION_MANAGER_ACCOUNT':  'Zaloguj się używając swojego konta Menadzera Tłumaczeń'
    'USERNAME':                                     'Nazwa użytkownika'

  })
])
