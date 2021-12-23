const express = require('express')
const port = 3000;
const app = express()//express logic acting as function
var bodyParser = require('body-parser'); //body-parser is a middleware
var urlencodedParser = bodyParser.urlencoded({ extended: false })  
app.use(express.static('public'));  

app.get('/',  (req, res) => {
res.sendFile(__dirname + '/index.html')

});


app.post('/register', urlencodedParser, (req, res) => {
    var firstName = req.body.firstName;
    console.log("First Name: "+firstName);
    var lastName = req.body.lastName;
    console.log("Last Name: "+lastName);
    if(firstName !== '' || lastName !== ''){
 
        res.sendFile(__dirname + '/success.html');
    }
else{
        res.sendFile(__dirname + '/error.html');
    }
  
});

app.listen(port, () => {
    console.log(`Example app listening at http://localhost:${port} on Express server`);
});