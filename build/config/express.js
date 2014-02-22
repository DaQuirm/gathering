var express, stylus;

express = require('express');

stylus = require('stylus');

module.exports = function(app, passport) {
  app.use(express["static"]('./public'));
  app.set('views', './app/views');
  app.set('view engine', 'jade');
  return app.configure(function() {
    app.use(express.cookieParser('secret'));
    app.use(express.bodyParser());
    app.use(express.session());
    app.use(passport.initialize());
    app.use(passport.session());
    return app.use(stylus.middleware('./public'));
  });
};
