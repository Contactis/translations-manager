module.exports =

  roles: [
    'public'
    'user'
    'translator'
    'programmer'
    'manager'
    'admin'
  ]
  accessLevels:
    'anon':             [ 'public' ]
    'programmer':       [ 'programmer' ]
    'user': [
      'user'
      'translator'
      'programmer'
      'manager'
      'admin'
    ]
    'translator-only':  [ 'translator' ]
    'programmer-only':  [ 'programmer' ]
    'manager':          [ 'manager' ]
    'admin':            [ 'admin' ]



