moment = require 'moment'

namespaces = [
  {
    parentId:   null
    name:       "Home"
    namespace:  "home_page"
    projectId:  1
  }
  {
    parentId:   1
    name:       "Login Page"
    namespace:  "login"
    projectId:  1
  }
  {
    parentId:   1
    name:       "Register"
    namespace:  "register"
    projectId:  1
  }
  {
    parentId:   2
    name:       "Forgot password"
    namespace:  "missing_password"
    projectId:  1
  }
  {
    parentId:   2
    name:       "Token reset"
    namespace:  "reset_token"
    projectId:  1
  }
]

namespaces.forEach (value, i) ->
  Namespace.seed value
