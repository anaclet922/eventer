const express = require('express');
const routerHome = express.Router()
const conn = require('../database');


const { getFormatedDate } = require('../helpers');

routerHome.use(function (req, res, next) {

    res.locals.getFormatedDate = getFormatedDate;

    next();

});

routerHome.get('/', async (req, res) => {

    const [hotels] = await (await conn).query("SELECT * FROM tbl_hotels WHERE listing = 1");

    let outuput = {
        hotels: hotels
    }
    res.render('register', outuput);

});


routerHome.post('/post-new-booking', async(req, res) => {

    let names = req.body.names;
    let email = req.body.email;
    let phone = req.body.phone;
    let hotel = req.body.hotel;
    let checkin = req.body.checkin;
    let checkout = req.body.checkout;

    const [i] = await (await conn).query("INSERT INTO 'tbl_hotels'('name', 'address', 'listing') VALUES (?,)");

});

module.exports = routerHome