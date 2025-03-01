const { Sequelize } = require('sequelize');

const sequelize = new Sequelize('postgres://postgres:nitocris@localhost:5432/Travel', {
    host: 'localhost',
    dialect: 'postgres', 
  });

module.exports = sequelize;