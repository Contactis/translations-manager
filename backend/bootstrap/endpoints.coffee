module.exports = (epilogue) ->

  epilogue.resource
    model:        orm.Languages
    endpoints:    ['/languages', '/languages/:id']
    associations: true

  epilogue.resource
    model:  orm.LanguagesTranslations
    endpoints: ['/languages-translations', '/languages-translations/:id']
    associations: true

  epilogue.resource
    model: orm.Groups
    endpoints: ['/groups', '/groups/:id']
    associations: true

  epilogue.resource
    model: orm.ProjectsLanguages
    endpoints: ['/projects-languages', '/projects-languages/:id']
    associations: true

  epilogue.resource
    model: orm.TranslationsKeys
    endpoints: ['/translations-keys', '/translations-keys/:id']
    associations: true

  epilogue.resource
    model: orm.Projects
    endpoints: ['/projects', '/projects/:id']
    associations: true
