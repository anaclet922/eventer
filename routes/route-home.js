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
    let country = req.body.country;
    let hotel = req.body.hotel;
    let checkin = req.body.checkin;
    let checkout = req.body.checkout;

    const [i] = await (await conn).query("INSERT INTO tbl_bookings (names, email, phone, country, hotel_id, checkin, checkout) VALUES (?,?,?,?,?,?,?)", [names, email, phone, country, hotel, checkin, checkout]);

    res.redirect('/en/booking-done');

});


routerHome.get('/booking-done', async(req, res) => {

    res.render('success-booking');

});


routerHome.get('/about-event', async (req, res) => {

    res.render('about-event');

});


routerHome.get('/contact', async (req, res) => {

    res.render('contact');

});

module.exports = routerHome