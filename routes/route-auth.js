const express = require('express');
const routerAuth = express.Router();
const bcrypt = require('bcrypt');
const conn = require('../database');


const { getFormatedDate } = require('../helpers');



routerAuth.get('/login', async (req, res) => {

    res.render('login');

});


routerAuth.post('/post-login', async (req, res) => {

let email = req.body.email;
let password = req.body.password;

const [user] = await (await conn).query("SELECT * FROM tbl_users WHERE email = ?", [email]);

if (user.length > 0) {

    let hash = user[0].password;

    bcrypt.compare(password, hash).then(function (result) {

        if (result == true) {    
            console.log('Logged in!');
            req.session.loggedin = true;
            req.session.loggedInUser = user[0];
            // return res.redirect('/adimini/home');
            return res.redirect('/adimini/bookings');

        } else {    
            req.flash('error', 'Incorrect credentials provided!');
            return res.redirect('/auth/login')
        }
    });

} else {
    req.flash('error', 'Incorrect credentials provided!')
    return res.redirect('/auth/login')
}

});

routerAuth.get('/logout', (req, res) => {
    req.session.destroy();
    res.redirect('/');
})


module.exports = routerAuth