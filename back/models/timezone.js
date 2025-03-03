const { DataTypes } = require('sequelize');

module.exports = (sequelize) => {
    return sequelize.define('timezone', {
        id: {
            type: DataTypes.INTEGER,
            primaryKey: true,
            allowNull: true,
        },
        timezone: {
            type: DataTypes.TEXT, 
            allowNull: false,      
        },
        
        }, {freezeTableName: true, timestamps: false}
    );
};