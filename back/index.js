const express = require("express");
const bodyParser = require("body-parser");
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
    console.log("База данных запущена");
  })
  .catch(err => {
    console.error("Ошибка запуска базы данных:", err);
  });

db.sequelize.authenticate()
  .then(() => {
    console.log("Соединение успешно установлено");
  })
  .catch(err => {
    console.error("Невозможно сеодиниться с базой данных", err);
  });
 
  app.get("/getClimateList", async (req, res) => {
    try {
      const transaction = await db.sequelize.transaction();
      try {
        const climate = await db.climate.findAll();

        res.json(climate);
        await transaction.commit();
      } catch (error) {
        console.error("Ошибка в получении данных климата:", error);
        await transaction.rollback();
        res.status(500).json({ error: "Не удалось получить данные климата" });
      }
  
    } catch (error) {
      console.error("Ошибка в старте транзакции:", error);
      res.status(500).json({ error: "Не удалось начать передачу данных"}); 
    }
  })

  app.get("/getTimezoneList", async (req, res) => {
    try {
      const transaction = await db.sequelize.transaction();
      try {
        const timezone = await db.timezone.findAll();

        res.json(timezone);
        await transaction.commit();
      } catch (error) {
        console.error("Ошибка в получении данных часового пояса:", error);
        await transaction.rollback();
        res.status(500).json({ error: "Не удалось получить данные часового пояса" });
      }
  
    } catch (error) {
      console.error("Ошибка в старте транзакции:", error);
      res.status(500).json({ error: "Не удалось начать передачу данных" }); 
    }
  })

  app.get("/getCityList", async (req, res) => {
    try {
      const transaction = await db.sequelize.transaction();
      try {
        const city = await db.city.findAll();

        res.json(city);
        await transaction.commit();
      } catch (error) {
        console.error("Ошибка в получении данных городов вылета:", error);
        await transaction.rollback();
        res.status(500).json({ error: "Не удалось получить данные по городам вылета" });
      }
  
    } catch (error) {
      console.error("Ошибка в старте транзакции:", error);
      res.status(500).json({ error: "Не удалось начать передачу данных" }); 
    }
  })


app.get("/getResult", async (req, res) => {
  console.log(req.query?.types);
  try {
    const transaction = await db.sequelize.transaction();

    const types=req.query?.types || [];
    const city = req.query?.city || null;


    const filter = {
      type: {
        [Op.in]: types,
      },
    };

    console.log(city,'city');

    if (city) {
      filter.city = {
       [Op.contains]: city,
      };
    }
   
    try {
      const travel = await db.travel.findAll({ transaction, logging: console.log, where:  filter });
      console.log(travel,'travel');
      res.json(travel);
      await transaction.commit();
    } catch (error) {
      console.error("Ошибка в получении данных travel:", error);
      await transaction.rollback();
      res.status(500).json({ error: "Не удалось получить travel данные" });
    }

  } catch (error) {
    console.error("Ошибка в старте транзакции:", error);
    res.status(500).json({ error: "Не удалось начать передачу данных" }); 
  }
});

app.listen(3000, () => {
  console.log("API is listening on port 3000");
});
