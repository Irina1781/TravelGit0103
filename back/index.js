const express = require("express");
const bodyParser = require("body-parser");
const mysql = require("mysql");
const cors = require("cors");
const db = require('./models/index');
const app = express();
const sequelize=require('./config/db');
const { Op } = require("sequelize");

app.use(cors());
app.use(bodyParser.json());

app.use(express.json({ limit: '500kb' }));

db.sequelize.sync({ alter: true }) 
  .then(() => {
    console.log('Database synced');
  })
  .catch(err => {
    console.error('Error syncing database:', err);
  });

db.sequelize.authenticate()
  .then(() => {
    console.log('Connection has been established successfully.');
  })
  .catch(err => {
    console.error('Unable to connect to the database:', err);
  });
 
  app.get("/getClimateList", async (req, res) => {
    try {
      const transaction = await db.sequelize.transaction();
      try {
        const climate = await db.climate.findAll();

        res.json(climate);
        await transaction.commit();
      } catch (error) {
        console.error("Error fetching travel data:", error);
        await transaction.rollback();
        res.status(500).json({ error: 'Failed to fetch travel data' });
      }
  
    } catch (error) {
      console.error("Error starting transaction:", error);
      res.status(500).json({ error: 'Failed to start transaction' }); 
    }
  })

  app.get("/getTimezoneList", async (req, res) => {
    try {
      const transaction = await db.sequelize.transaction();
      try {
        const climate = await db.timezone.findAll();

        res.json(timezone);
        await transaction.commit();
      } catch (error) {
        console.error("Error fetching timezone data:", error);
        await transaction.rollback();
        res.status(500).json({ error: 'Failed to fetch timezone data' });
      }
  
    } catch (error) {
      console.error("Error starting transaction:", error);
      res.status(500).json({ error: 'Failed to start transaction' }); 
    }
  })
app.get("/getResult", async (req, res) => {
  console.log(req.query?.types);
  try {
    const transaction = await db.sequelize.transaction();

    const types=req.query?.types || [];
    try {
      const travel = await db.travel.findAll({ transaction, logging: console.log, where: {
        type: {
          [Op.in]: types,
        },
      },
    });
      //console.log(travel);
      res.json(travel);
      await transaction.commit();
    } catch (error) {
      console.error("Error fetching travel data:", error);
      await transaction.rollback();
      res.status(500).json({ error: 'Failed to fetch travel data' });
    }

  } catch (error) {
    console.error("Error starting transaction:", error);
    res.status(500).json({ error: 'Failed to start transaction' }); 
  }
});

app.listen(3000, () => {
  console.log("API is listening on port 3000");
});
