const express = require('express');
const server = express();
const port = 3000;
const cors = require('cors');
const CORS_OPTIONS = { origin: 'http://localhost:4200', optionsSuccessStatus: 200 };
server.use(express.json());
server.use(express.urlencoded({ extended: true }));
server.use(cors(CORS_OPTIONS));
//################ sync with database
const db = require('./db1/models');
db.sequelize.sync();


//################ default route:: http://localhost:3000/
server.get('/', (req, res) => {
    res.send('Hello World!');
});

server.use((req,res,next)=>{
    console.log('within cors configuration middleware');
    // res.setHeader('Content-Type', 'text/plain')
    res.setHeader('Access-Control-Allow-Origin','*');
    res.setHeader('Access-Control-Allow-Headers',
    'Origin, X-Requested-with,Content-Type,Accept,Authorization');
    res.setHeader('Access-Control-Allow-Methods','GET,POST,PUT,DELETE');
    next();

});

//################ http://localhost:3000/app/
require('./app/app-route')(server);

server.listen(port, () => {
    console.log(`http://localhost:${port} started`);
});
