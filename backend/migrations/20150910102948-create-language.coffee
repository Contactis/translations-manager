module.exports =
  up: (queryInterface, Sequelize) ->
    queryInterface.createTable 'Languages',
      id:
        allowNull: false
        autoIncrement: true
        primaryKey: true
        type: Sequelize.INTEGER
      nameNative: type: Sequelize.STRING
      nameEnglish: type: Sequelize.STRING
      codeIetf: type: Sequelize.STRING
      description: type: Sequelize.STRING
  down: (queryInterface, Sequelize) ->
    queryInterface.dropTable 'Languages'
