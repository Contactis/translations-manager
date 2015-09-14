module.exports = (sequelize, DataTypes) ->
  LanguageTranslations = sequelize.define('LanguageTranslations', {
    language_id: DataTypes.INTEGER
    plural_form: DataTypes.INTEGER
  },
  {
    timestamps:   false
  }, classMethods: associate: (models) ->
    # associations can be defined here
    return
  )

  LanguageTranslations.removeAttribute 'id'
  LanguageTranslations
