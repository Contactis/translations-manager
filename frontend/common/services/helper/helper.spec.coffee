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
      _array1 = null
      _array2 = null
      return


    # Public tests
    describe "checking existing of:", () ->
      it "method `diffArrayObjects` should be defined", () ->
        expect(typeof HelperService.diffArrayObjects).toBe 'function'


    describe '`diffArrayObjects()` function:', () ->
      it 'should pass if both array1 and array2 are Array Objects', () ->
        array1 = []
        array2 = []
        foo = () ->
          HelperService.diffArrayObjects(array1, array2)
        expect(foo).not.toThrow()

      it 'should throw error if array2 is String', () ->
        array1 = []
        array2 = ""
        foo = () ->
          HelperService.diffArrayObjects(array1, array2)
        expect(foo).toThrow()


    describe '`partitionArrayByParameter()` function:', () ->
      it 'should not throw error if arguments of method are correct', () ->
        array1 = []
        array2 = []
        foo = ->
          HelperService.partitionArrayByParameter(array1, array2, 'vorname')
        expect(foo).not.toThrow()

      it 'should throw error if arguments of method are incorrect', () ->
        array1 = []
        array2 = ""
        foo = ->
          HelperService.partitionArrayByParameter(array1, array2, 'vorname')
        expect(foo).toThrow()

      it 'should throw error if last argument (equalKey) of method are missing', () ->
        array1 = []
        array2 = []
        foo = ->
          HelperService.partitionArrayByParameter(array1, array2)
        expect(foo).toThrow()


      it 'should return 1 common and 2 diff Objects', () ->
        array1 = _array1
        array2 = _array2
        foo = HelperService.partitionArrayByParameter(array1, array2, 'vorname')
        expect(foo[0].length).toEqual(1)
        expect(foo[1].length).toEqual(2)

      it 'should returns 1 common and 1 diff Objects', () ->
        array1 = _array2
        array2 = _array1
        foo = HelperService.partitionArrayByParameter(array1, array2, 'vorname')
        expect(foo[0].length).toEqual(1)
        expect(foo[1].length).toEqual(1)


    describe '`partitionGreaterArrayByParameter()` function:', () ->
      it 'should not throw error if arguments of method are correct', () ->
        array1 = _array1
        array2 = _array2
        foo = ->
          HelperService.partitionGreaterArrayByParameter(array1, array2, 'vorname')
        expect(foo).not.toThrow()

      it 'should throw error if arguments of method are incorrect', () ->
        array1 = _array1
        array2 = ""
        foo = ->
          HelperService.partitionGreaterArrayByParameter(array1, array2, 'vorname')
        expect(foo).toThrow()

      it 'should throw error if last argument (equalKey) of method are missing', () ->
        array1 = []
        array2 = []
        foo = ->
          HelperService.partitionGreaterArrayByParameter(array1, array2)
        expect(foo).toThrow()

      it 'should take bigger array if they are switched', () ->
        array1 = _array2
        array2 = _array1
        foo = ->
          HelperService.partitionGreaterArrayByParameter(array1, array2, 'vorname')
        expect(foo()[0].length).toEqual(1)
        expect(foo()[1].length).toEqual(2)

      it 'should pass on more complex arrays of objects', () ->
        array1 = [
          {
            "id": 1,
            "realm": null,
            "username": "Sir Admin",
            "credentials": null,
            "challenges": null,
            "email": "admin@admin.com",
            "emailVerified": true,
            "verificationToken": null,
            "status": null,
            "created": "1970-01-01T00:00:00.000Z",
            "lastUpdated": "2015-11-23T20:24:32.000Z",
            "firstName": "Sir Super",
            "lastName": "Admin",
            "role": "admin",
            "interfaceLanguage": "en-us"
          },
          {
            "id": 2,
            "realm": null,
            "username": "Sir Manager",
            "credentials": null,
            "challenges": null,
            "email": "manager@manager.com",
            "emailVerified": true,
            "verificationToken": null,
            "status": null,
            "created": "1970-01-01T00:00:00.000Z",
            "lastUpdated": "2015-11-23T20:24:32.000Z",
            "firstName": "Sir Super",
            "lastName": "Manager",
            "role": "user",
            "interfaceLanguage": "en-us"
          },
          {
            "id": 3,
            "realm": null,
            "username": "Sir Translator",
            "credentials": null,
            "challenges": null,
            "email": "translator@translator.com",
            "emailVerified": true,
            "verificationToken": null,
            "status": null,
            "created": "1970-01-01T00:00:00.000Z",
            "lastUpdated": "2015-11-23T20:24:32.000Z",
            "firstName": "Sir Super",
            "lastName": "Translator",
            "role": "user",
            "interfaceLanguage": "en-us"
          },
          {
            "id": 4,
            "realm": null,
            "username": "Sir Programmer",
            "credentials": null,
            "challenges": null,
            "email": "programmer@programmer.com",
            "emailVerified": true,
            "verificationToken": null,
            "status": null,
            "created": "1970-01-01T00:00:00.000Z",
            "lastUpdated": "2015-11-23T20:24:32.000Z",
            "firstName": "Sir Super",
            "lastName": "Programmer",
            "role": "user",
            "interfaceLanguage": "en-us"
          }
        ]
        array2 = [
          {
            "id": 1,
            "realm": null,
            "username": "Sir Admin",
            "credentials": null,
            "challenges": null,
            "email": "admin@admin.com",
            "emailVerified": true,
            "verificationToken": null,
            "status": null,
            "created": "1970-01-01T00:00:00.000Z",
            "lastUpdated": "2015-11-23T20:24:32.000Z",
            "firstName": "Sir Super",
            "lastName": "Admin",
            "role": "admin",
            "interfaceLanguage": "en-us"
          },
          {
            "id": 2,
            "realm": null,
            "username": "Sir Manager",
            "credentials": null,
            "challenges": null,
            "email": "manager@manager.com",
            "emailVerified": true,
            "verificationToken": null,
            "status": null,
            "created": "1970-01-01T00:00:00.000Z",
            "lastUpdated": "2015-11-23T20:24:32.000Z",
            "firstName": "Sir Super",
            "lastName": "Manager",
            "role": "user",
            "interfaceLanguage": "en-us"
          }
        ]
        foo = HelperService.partitionGreaterArrayByParameter(array1, array2, 'id')
        expect(foo[0].length).toEqual(2)
        expect(foo[1].length).toEqual(2)
