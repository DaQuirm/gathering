var app, db, exports, express, mongoose, passport, path;

path = require('path');

express = require('express');

passport = require('passport');

mongoose = require('mongoose');

mongoose.connect('mongodb://localhost/test');

db = mongoose.connection;

db.on('error', console.error.bind(console, 'connection error:'));

(require('./config/passport'))(passport);

require('./app/models/user');

app = express();

require('./config/express')(app, passport);

require('./config/routes')(app, passport);

app.listen(3000);

exports = module.exports = app;
