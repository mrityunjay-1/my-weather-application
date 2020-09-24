const path = require('path');
const express = require('express');
const hbs = require('hbs');

const {geocoding, forecast} =  require('./weather-app-modules/geocoding');

const server1 = express();
const port  = process.env.PORT || 8080;


server1.set('view engine', 'hbs');

server1.set('views', path.join(__dirname, '/templates/views'));
hbs.registerPartials(path.join(__dirname, '/templates/partials') );




server1.get('/weather', (req, res) => {
    res.render('index');
})
server1.get('/weather/:place', (req, res) => {
    
    let place = req.params.place;

    geocoding(place, (error, data) => {
        if(error){
            return res.status(500).send({message: 'some error ocurred'});
        }
        forecast(data.latitude, data.longitude, (error, forecastdata) => {
            if(error){
                return res.status(500).send({error: 'something went wrong'});
            }
            const temp = `temperature = ${forecastdata.body.current.temperature} F and there is ${forecastdata.body.current.cloudcover} % chance of rain.`;
            
    
            res.status(200).send({
                data: temp
            });
        })  
    })
})

server1.listen(port, () =>{
    console.log('Server is up at port:' + port);
})