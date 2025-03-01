const travelmodel=require('./travel');
const climateModel=require('./climate');
const timezoneModel=require('./timezone')
const sequelize = require('../config/db');
const Sequelize = require('sequelize');

const db={};

db.sequelize = sequelize;
db.Sequelize = Sequelize;
db.travel=travelmodel(sequelize);
db.climate = climateModel(sequelize);
db.timezone=timezoneModel(sequelize);
module.exports = db;