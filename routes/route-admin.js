const express = require('express');
const routerAdmin = express.Router()
const conn = require('../database');
const upload = require('../upload');
const ExcelJS = require('exceljs');
const path = require('path');
var mv = require('mv');



const { getFormatedDate } = require('../helpers');
const { group } = require('console');



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



routerAdmin.get('/invite', async (req, res) => {

    const [categories] = await (await conn).query("SELECT *  FROM tbl_categories ORDER BY category DESC");
    const [guests] = await (await conn).query("SELECT tbl_guests.id as guest_id, tbl_guests.*, tbl_categories.*  FROM tbl_guests LEFT JOIN tbl_categories ON tbl_categories.id = tbl_guests.category_id ORDER BY category DESC");

    let page_data = {
        title: "Invitees",
        currrentPath: "invite",
        categories: categories,
        guests: guests
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

routerAdmin.post('/post-new-invitee', async (req, res) => {
    try {
        let name = req.body.name;
        let email = req.body.email;
        let phone = req.body.phone;
        let country = req.body.country;
        let category_id = req.body.category_id;

        const [email_check] = await (await conn).query("SELECT * FROM tbl_guests WHERE email = ?", [email]);
        if (email_check.length) {
            req.flash('error', 'Guest with same email exist!');
            return res.redirect('/adimini/invite');
        }


        const [phone_check] = await (await conn).query("SELECT * FROM tbl_guests WHERE phone = ?", [phone]);
        if (phone_check.length) {
            req.flash('error', 'Guest with same phone exist!');
            return res.redirect('/adimini/invite');
        }

        const [i] = await (await conn).query("INSERT INTO tbl_guests (names, email, phone, country, category_id) VALUES (?,?,?,?,?)", [name, email, phone, country, category_id]);

        req.flash('success', 'Invitee Successfully Saved!');
        res.redirect('/adimini/invite');

    } catch (error) {
        console.log(error);
        req.flash('error', 'Error happened, try again!');
        res.redirect('/adimini/invite');
    }
});


const excelUpload = upload.fields([{ name: "file", maxCount: 1 }]);
routerAdmin.post('/post-new-invitee-excel', excelUpload, async (req, res) => {
    let excel = req.files.file[0].filename;
    let category_id = req.body.category_id;
    const workbook = new ExcelJS.Workbook();
    const filePath = path.resolve('uploads', excel);

    try {
        await workbook.xlsx.readFile(filePath);

        // Assuming the data is in the first worksheet
        const worksheet = workbook.getWorksheet(1);

        const failedData = [];


        const processRows = async (worksheet, conn, category_id) => {

            var failedData = [];

            try {
                await worksheet.eachRow(async (row, rowNumber) => {
                    if (rowNumber == 1) {
                        return;
                    }

                    // Access cell values by column name or index
                    const name = row.getCell(1).value;
                    let email = row.getCell(2).value;
                    const phone = row.getCell(3).value;
                    const country = row.getCell(4).value;

                    if (!name || !email || !phone) {
                        failedData.push({ name, email, phone, country });
                        return;
                    }

                    if (!country) {
                        country = '';
                    }

                    email = email.toString().replace('mailto:', '');


                    const [email_check] = await (await conn).query("SELECT * FROM tbl_guests WHERE email = ?", [email]);
                    if (email_check.length) {
                        failedData.push({ name, email, phone, country });
                        return;
                    }

                    // const [phone_check] = await (await conn).query("SELECT * FROM tbl_guests WHERE phone = ?", [phone]);
                    // if (phone_check.length) {
                    //     failedData.push({ name, email, phone, country });
                    //     return;
                    // }

                    const [i] = await (await conn).query("INSERT INTO tbl_guests (names, email, phone, country, category_id) VALUES (?,?,?,?,?)", [name, email, phone, country, category_id]);
                });

                return failedData;
            } catch (error) {
                throw error;
            }
        };

        // Now, use await on the processRows function
        try {
            const failedData = await processRows(worksheet, conn, category_id);

            req.flash('success', 'Saved!');
            return res.redirect('/adimini/invite');

        } catch (error) {
            console.error('Error processing rows:', error);

            req.flash('error', 'Completed with error!');
            return res.redirect('/adimini/invite');;
        }


    } catch (error) {
        console.error('Error reading Excel file:', error.message);

        req.flash('error', 'Completed with error!');
        return res.redirect('/adimini/invite');
    }

});


routerAdmin.get('/guests-tables', async (req, res) => {

    let g = req.query.g;
    let group = 8;
    const [guests] = await (await conn).query("SELECT tbl_guests.id as guest_id, tbl_guests.*, tbl_categories.*  FROM tbl_guests LEFT JOIN tbl_categories ON tbl_categories.id = tbl_guests.category_id ORDER BY category DESC");

    if(g !== undefined){
        group = g;
    }
    const groupedGuests = [];
    for (let i = 0; i < guests.length; i += group) {
        groupedGuests.push(guests.slice(i, i + 8));
    }

    console.log(groupedGuests);
    
    let page_data = {
        title: "Tables Arrangements",
        currrentPath: "invite",
        guests: groupedGuests
    };

    res.render('admin/guests-tables', page_data);

});


module.exports = routerAdmin