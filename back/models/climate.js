const { DataTypes } = require('sequelize');

module.exports = (sequelize) => {
    return sequelize.define('climate', {
        id: {
            type: DataTypes.INTEGER,
            primaryKey: true,
            allowNull: true,
        },
        climate: {
            type: DataTypes.TEXT, 
            allowNull: false,      
        },
        
        }, {freezeTableName: true, timestamps: false,}
    );
};
