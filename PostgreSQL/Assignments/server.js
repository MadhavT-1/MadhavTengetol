const express = require('express');
const server = express();
const port = 3000;
const cors = require('cors');
const CORS_OPTIONS = { origin: 'http://localhost:3000', optionsSuccessStatus: 200 };
server.use(express.json());
server.use(express.urlencoded({ extended: true }));
server.use(cors(CORS_OPTIONS));
//################ sync with database
const DB = require('./Book/db/models');
DB.sequelize.sync();
//################ default route:: http://localhost:3000/
server.get('/', (req, res) => {
    res.send('Hello World!');
});



//################ http://localhost:3000/app/Book/
require('./Book/app/app-route')(server);
require('./Car/app/app-route')(server);
// require('./Hero/app/app-route')(server);
require('./Account/app/app-route')(server);
require('./Author/app/app-route')(server);
require('./Heroes/app/app-route')(server);


server.listen(port, () => {
    console.log(`http://localhost:${port} started`);
});
