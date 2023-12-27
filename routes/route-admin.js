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


routerAdmin.get('/home', (req, res) => {

    let page_data = {
        title: "Home",
        currrentPath: "home"
    };

    res.render('admin/home', page_data);

});


routerAdmin.get('/bookings', async (req, res) => {

    const [bookings] = await (await conn).query("SELECT tbl_bookings.id AS booking_id, tbl_bookings.*, tbl_hotels.*  FROM tbl_bookings LEFT JOIN tbl_hotels ON tbl_hotels.id = tbl_bookings.hotel_id ORDER BY booking_id DESC");

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



routerAdmin.get('/categories', async (req, res) => {

    const [categories] = await (await conn).query("SELECT *  FROM tbl_categories ORDER BY category DESC");

    let page_data = {
        title: "Categories",
        currrentPath: "categories",
        categories: categories
    };

    res.render('admin/categories', page_data);

});



routerAdmin.post('/post-category', async (req, res) => {

    let category = req.body.category;

    const [i] = await (await conn).query("INSERT INTO tbl_categories (category) VALUES (?)", [category]);

    req.flash('success', 'New category successfully added!');
    res.redirect('/adimini/categories');

});


routerAdmin.get('/delete-category', async (req, res) => {

    try {
        let id = req.query.id;


        const [guests] = await (await conn).query("SELECT *  FROM tbl_guests WHERE category_id = ?", [id]);

        if (guests.length) {
            req.flash('error', 'First delete guests in this category!');
            return res.redirect('/adimini/categories');
        }

        const [d] = await (await conn).query("DELETE FROM tbl_categories WHERE id = ?", [id]);
        req.flash('success', 'Category successfully deleted!');
        res.redirect('/adimini/categories');
    } catch (error) {
        req.flash('error', 'Error happened, try again!');
        res.redirect('/adimini/categories');
    }

});


routerAdmin.post('/post-edit-category', async (req, res) => {

    try {
        let id = req.body.id;
        let category = req.body.category;

        const [titl_check] = await (await conn).query("SELECT * FROM tbl_categories WHERE category = ? AND  id != ? ", [category, id]);
        if (titl_check.length) {
            req.flash('error', 'Category with same title!');
            return res.redirect('/adimini/categories');
        }

        const [i] = await (await conn).query("UPDATE tbl_categories SET category = ? WHERE id = ?", [category, id]);

        req.flash('success', 'Category successfully Updated!');
        res.redirect('/adimini/categories');

    } catch (error) {
        req.flash('error', 'Error happened, try again!');
        res.redirect('/adimini/categories');
    }

});




module.exports = routerAdmin