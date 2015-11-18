angular.module('translation.pages.admin.project-assignment', [
  'lbServices'
])
.config ($stateProvider, UserPermissionsSettingsProvider) ->

  access = UserPermissionsSettingsProvider.accessLevels

  $stateProvider.state 'app.admin.project-assignment',
    url:            '/project-assignment'
    controller:     'ProjectAssignmentController'
    controllerAs:   'vm'
    templateUrl:    'admin/projectAssignment/projectAssignment.tpl.html'
    data:
      access: access.management

.controller 'ProjectAssignmentController', (Project, Account) ->

  vm = this

  vm.projects = {}
  vm.accounts = {}

  Project.find
    filter:
      include: [
        'accounts'
      ]
  .$promise.then (response) ->
    vm.projects = response

  Account.find().$promise.then (response) ->
    vm.accounts = response





  ###*
  # Search for contacts.
  ###

  querySearch = (query) ->
    results = if query then vm.allContacts.filter(createFilterFor(query)) else []
    results

  ###*
  # Create filter function for a query string
  ###

  createFilterFor = (query) ->
    lowercaseQuery = angular.lowercase(query)
    (contact) ->
      contact._lowername.indexOf(lowercaseQuery) != -1

  loadContacts = ->
    contacts = [
      'Marina Augustine'
      'Oddr Sarno'
      'Nick Giannopoulos'
      'Narayana Garner'
      'Anita Gros'
      'Megan Smith'
      'Tsvetko Metzger'
      'Hector Simek'
      'Some-guy withalongalastaname'
    ]
    return contacts.map (c, index) ->
      cParts = c.split(' ')
      contact =
        name: c
        email: cParts[0][0].toLowerCase() + '.' + cParts[1].toLowerCase() + '@example.com'
        image: 'http://lorempixel.com/50/50/people?' + index
      contact._lowername = contact.name.toLowerCase()
      return contact

  vm.querySearch = querySearch
  vm.allContacts = loadContacts()
  vm.contacts = [
    vm.allContacts[0]
    vm.allContacts[1]
    vm.allContacts[2]
  ]
  vm.filterSelected = true



  return vm

