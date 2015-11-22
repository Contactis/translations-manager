describe "Unit testing: translation.services.helper Module >", () ->

  describe "for HelperService >", () ->
    HelperService   = null
    _array1         = null
    _array2         = null

    # load required modules
    beforeEach () ->
      module 'translation.services.helper'

      _array1 = [
        {
          vorname:  "Albert"
          nachname: "Einstain"
        }
        {
          vorname:  "Thomas"
          nachname: "Edison"
        }
        {
          vorname:  "Leonardo"
          nachname: "Da Vinci"
        }
      ]

      _array2 = [
        {
          vorname:  "Pablo"
          nachname: "Picasso"
        }
        {
          vorname:  "Leonardo"
          nachname: "Da Vinci"
        }
      ]

    # Injecting required services
    beforeEach inject ( $injector ) ->
      #load services
      HelperService   = $injector.get 'HelperService'
      return

    afterEach () ->
      return


    # Public tests
    describe "checking existing of:", () ->
      it "method `diffArrayObjects` should be defined", () ->
        expect(typeof HelperService.diffArrayObjects).toBe 'function'


    describe '`diffArrayObjects()` function:', () ->
      it 'should pass if both array1 and array2 are real Array Objects', () ->
        array1 = []
        array2 = []
        foo = () ->
          HelperService.diffArrayObjects(array1, array2)
        expect(foo).not.toThrow()

      it 'should not pass if one of array1 or array2 are not real Array Object', () ->
        array1 = []
        array2 = ""
        foo = () ->
          HelperService.diffArrayObjects(array1, array2)
        expect(foo).toThrow()

      # it 'should not pass if one of array1 or array2 are not real Array Object', () ->
      #   array1 = _array1
      #   array2 = _array2
      #   foo = HelperService.diffArrayObjects(array1, array2, 'vorname')
      #   expect(foo).toEqual(0)

      # it 'should not pass if one of array1 or array2 are not real Array Object', () ->
      #   array1 = _array1
      #   array2 = _array2
      #   foo = HelperService.diffArrayObjects(array2, array1 'vorname')
      #   expect(foo).toEqual(0)


