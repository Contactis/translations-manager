orm = require '../models/index'
GLOBAL.orm = orm

# Translations
orm.Translations.belongsTo(orm.TranslationsStatuses, {
  foreignKey:
    name:       'statusId'
    allowNull:  false
})
orm.Translations.belongsTo(orm.TranslationsKeys, {
  foreignKey:
    name:       'translationKeyId'
    allowNull:  false
})
orm.Translations.belongsTo(orm.Languages, {
  foreignKey:
    name:       'languageId'
    allowNull:  false
})
orm.Translations.belongsTo(orm.Users, {
  foreignKey:
    name:       'lastModifiedBy'
    allowNull:  false
})


# ProjectsUsers
orm.Users.belongsToMany(orm.Projects, { through: 'ProjectsUsers' })
orm.Projects.belongsToMany(orm.Users, { through: 'ProjectsUsers' })


# ProjectsLanguages
orm.Languages.belongsToMany(orm.Projects, { through: 'ProjectsLanguages' })
orm.Projects.belongsToMany(orm.Languages, { through: 'ProjectsLanguages' })


# Projects
orm.Projects.belongsTo(orm.Languages, {
  foreignKey:
    name:       'defaultLanguage'
    allowNull:  false
})


# TranslationsKeys
orm.TranslationsKeys.belongsTo(orm.Projects, {
  foreignKey:
    name:       'projectId'
    allowNull:  false
})
orm.TranslationsKeys.belongsTo(orm.Groups, {
  foreignKey:
    name:       'groupId'
    allowNull:  false
})

# LanguagesTranslations
orm.Languages.belongsToMany(orm.Translations, { through: 'LanguagesTranslations' })
orm.Translations.belongsToMany(orm.Languages, { through: 'LanguagesTranslations' })
