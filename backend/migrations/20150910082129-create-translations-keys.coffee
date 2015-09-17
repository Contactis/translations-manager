module.exports =
  up: (queryInterface, Sequelize) ->
    queryInterface.createTable 'TranslationsKeys',
      id:
        type:           Sequelize.INTEGER.UNSIGNED
        primaryKey:     true
        autoIncrement:  true
        allowNull:      false
      keyString:
        type:           Sequelize.STRING(600)
        allowNull:      false
      isPlural:
        type:           Sequelize.BOOLEAN
      projectId:
        type:           Sequelize.INTEGER.UNSIGNED
        allowNull:      false
        references:
          model:        "Projects"
          key:          "id"
      groupId:
        type:           Sequelize.INTEGER.UNSIGNED
        references:
          model:        "Groups"
          key:          "id"
  down: (queryInterface, Sequelize) ->
    queryInterface.dropTable 'TranslationsKeys'
