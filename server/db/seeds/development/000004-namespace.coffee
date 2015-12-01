moment = require 'moment'

namespaces = [
  {
    parentId:     null
    namespace:    "home_page"
    description:  "Home"
    projectId:    1
  }
  {
    parentId:     1
    description:  "Login Page"
    namespace:    "login"
    projectId:    1
  }
  {
    parentId:     1
    description:  "Register"
    namespace:    "register"
    projectId:    1
  }
  {
    parentId:     2
    description:  "Forgot password"
    namespace:    "missing_password"
    projectId:    1
  }
  {
    parentId:     2
    description:  "Token reset"
    namespace:    "reset_token"
    projectId:    1
  }
]

namespaces.forEach (value, i) ->
  Namespace.seed value
