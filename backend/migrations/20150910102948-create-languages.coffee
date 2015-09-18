module.exports =
  up: (queryInterface, Sequelize) ->
    queryInterface.createTable 'Languages',
      id:
        type:           Sequelize.INTEGER.UNSIGNED
        autoIncrement:  true
        primaryKey:     true
        allowNull:      false
      nameNative:
        type:           Sequelize.STRING
        allowNull:      false
      nameEnglish:
        type:           Sequelize.STRING
        allowNull:      false
      ietfCode:
        type:           Sequelize.STRING(10)
        allowNull:      false
      description:
        type:           Sequelize.TEXT
  down: (queryInterface, Sequelize) ->
    queryInterface.dropTable 'Languages'
