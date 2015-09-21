orm = require '../models/index'
GLOBAL.orm = orm


#Project
orm.Projects.hasMany orm.ProjectsLanguages

orm.Projects.hasMany orm.Groups

orm.Projects.hasMany orm.ProjectsUsers


# ## Groups
orm.Groups.hasMany orm.TranslationsKeys


# Users
orm.Users.hasMany orm.ProjectsUsers

# Translations

orm.TranslationsKeys.hasMany orm.Translations


# Languages
orm.Languages.hasMany orm.ProjectsLanguages
