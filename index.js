const express = require('express')
const session = require('express-session');
const path = require('path');
const flash = require('connect-flash');
const conn = require('./database');

const app = express()

app.use(session({
    secret: 'This a  secret for session encoding',
    resave: true,
    saveUninitialized: true,
    cookie: {
        sameSite: 'strict'
    }
}));

app.set('view engine', 'ejs');
app.use(express.json());
app.use(express.urlencoded({ extended: true }));
app.use(flash());

app.use(express.static(path.join(__dirname, 'public')))
app.use(express.static(path.join(__dirname, 'uploads')));



app.use(async function (req, res, next) {

    res.locals.session = req.session;
    var configs = [];

    const [config] = await (await conn).query("SELECT * FROM tbl_configs");

    for (var i in config) {
        configs[config[i].config_key] = config[i].value;
    }
    res.locals.configs = configs;
    res.locals.message = req.flash();
    next();

});


const homeRouter = require('./routes/route-home');
app.use('/en', homeRouter);

const authRouter = require('./routes/route-auth');
app.use('/auth', authRouter);


const adminRouter = require('./routes/route-admin');
app.use('/adimini', adminRouter);



app.get('/', (req, res) =>{
        res.redirect('/en');
});




app.listen(3000, () => console.log('App is listening via post 3000'))