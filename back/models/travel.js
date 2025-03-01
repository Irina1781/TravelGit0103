const { DataTypes } = require('sequelize');

module.exports = (sequelize) => {
    const travel = sequelize.define('travel_search', {
        id: {
            type: DataTypes.INTEGER,
            primaryKey: true,
            allowNull: true,
        },
        name: {
            type: DataTypes.TEXT, 
            allowNull: false,      
        },
        photo: {
            type: DataTypes.TEXT, 
            allowNull: false,       
        },
        description: {
            type: DataTypes.TEXT, 
            allowNull: false,      
        },
        geo: {                  
            type: DataTypes.TEXT, 
            allowNull: false, 
            
        },
        type: {                  
            type: DataTypes.INTEGER, 
            allowNull: false, 
            
        },
        climate: {                  
            type: DataTypes.INTEGER, 
            allowNull: false,         
        },
        timezone: {                  
            type: DataTypes.INTEGER, 
            allowNull: false,          
        },
        cost: {                  
            type: DataTypes.INTEGER, 
            allowNull: false, 
           
        },
        city: {                  
            type: DataTypes.ARRAY(DataTypes.TEXT), 
            allowNull: false, 
                    },
        more: {                  
            type: DataTypes.TEXT, 
            allowNull: false,           
        },
    },{freezeTableName: true, timestamps: false,}
);

    return travel;
};
