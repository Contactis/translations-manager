module.exports = (epilogue) ->

  epilogue.resource
    model: orm.Languages
    endpoints: ['/languages', '/languages/:id']

  epilogue.resource
    model:  orm.LanguagesTranslations
    endpoints: ['/languages-translations', '/languages-translations/:id']

  epilogue.resource
    model: orm.Groups
    endpoints: ['/groups', '/groups/:id']

  epilogue.resource
    model: orm.ProjectsLanguages
    endpoints: ['/projects-languages', '/projects-languages/:id']

  epilogue.resource
    model: orm.TranslationsKeys
    endpoints: ['/translations-keys', '/translations-keys/:id']

  epilogue.resource
    model: orm.Projects
    endpoints: ['/projects', '/projects/:id']
