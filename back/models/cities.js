const { DataTypes } = require('sequelize');

module.exports = (sequelize) => {
    return sequelize.define('city', {
        id: {
            type: DataTypes.INTEGER,
            primaryKey: true,
            allowNull: true,
        },
        city: {
            type: DataTypes.TEXT, 
            allowNull: false,      
        },
        
        }, {freezeTableName: true, timestamps: false}
    );
};