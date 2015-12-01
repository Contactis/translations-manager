describe "Unit testing: translation.services.plural Module >", () ->

  describe "for PluralService >", () ->
    PluralService   = null

    # load required modules
    beforeEach () ->
      module 'translation.services.plural'

    # Injecting required services
    beforeEach inject ( $injector ) ->
      #load services
      PluralService   = $injector.get 'PluralService'
      return

    afterEach () ->
      return


    # Public tests
    describe "checking existing of:", () ->
      it "method `getPlural` should be defined", () ->
        expect(typeof PluralService.getPlural).toBe 'function'
      it "method `getAllPlurals` should be defined", () ->
        expect(typeof PluralService.getAllPlurals).toBe 'function'


    describe '`getAllPlurals()` function:', () ->
      it 'should return not empty Array', () ->
        result = PluralService.getAllPlurals()
        expect(Object.prototype.toString.call(result)).toBe('[object Array]')
        expect(result.length).toBeGreaterThan(0)


    describe '`getPlural()` function:', () ->
      it 'should return proprt object', () ->
        result = PluralService.getPlural(1)
        expect(result.name).toEqual("one")
