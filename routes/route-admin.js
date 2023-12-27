const express = require('express');
const routerAdmin = express.Router()
const conn = require('../database');


const { getFormatedDate } = require('../helpers');



routerAdmin.use(function (req, res, next) {

    if (!req.session.loggedin) {
        return res.redirect('/auth/login');
    }

    res.locals.getFormatedDate = getFormatedDate;

    next();

});


routerAdmin.get('/home', (req, res) =>{

    let page_data = {
        title: "Home",
        currrentPath: "home"
    };

    res.render('admin/home', page_data);    

});


routerAdmin.get('/bookings', async (req, res) => {

    const [bookings] = await (await conn).query("SELECT * FROM tbl_bookings ORDER BY id DESC");

    let page_data = {
        title: "Bookings",
        currrentPath: "bookings",
        bookings: bookings
    };

    res.render('admin/bookings', page_data);    

});



routerAdmin.get('/invite', (req, res) => {

    let page_data = {
        title: "Invite",
        currrentPath: "invite"
    };

    res.render('admin/invite', page_data);    

});



routerAdmin.get('/categories', (req, res) => {

    let page_data = {
        title: "Categories",
        currrentPath: "categories"
    };

    res.render('admin/categories', page_data);    

});





module.exports = routerAdmin