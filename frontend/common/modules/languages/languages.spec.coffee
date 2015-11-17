describe "Unit testing: translation.modules.languages Module >", () ->

  describe "for LanguagesService >", () ->

    $rootScope            = null
    $cookieStore          = null
    LanguagesService      = null

    # load required modules
    beforeEach () ->
      module 'translation.modules.languages'

    # Injecting required services
    beforeEach inject ( $injector ) ->
      #load services
      $rootScope            = $injector.get '$rootScope'
      $cookieStore          = $injector.get '$cookieStore'
      LanguagesService      = $injector.get 'LanguagesService'
      return

    afterEach () ->
      return


    # Public tests
    describe "checking existing of:", () ->
      it "method `getInterfaceLanguages` should be defined", () ->
        expect(typeof LanguagesService.getInterfaceLanguages).toBe 'function'

      it "method `getStartupLanguage` should be defined", () ->
        expect(typeof LanguagesService.getStartupLanguage).toBe 'function'

      it "method `setLanguage` should be defined", () ->
        expect(typeof LanguagesService.setLanguage).toBe 'function'

      it "method `unifyToIetfCode` should be defined", () ->
        expect(typeof LanguagesService.unifyToIetfCode).toBe 'function'


