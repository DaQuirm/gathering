express       = require 'express'
cookie_parser = require 'cookie-parser'
body_parser   = require 'body-parser'
session       = require 'express-session'
flash         = require 'express-flash'

module.exports = (app, passport) ->
	app.use express.static('./public')
	app.use do cookie_parser
	app.use do body_parser.json
	app.use body_parser.urlencoded extended:no
	app.use session
		secret: 'keyboard cat'
		saveUninitialized: true
		resave: true
	app.use do passport.initialize
	app.use do passport.session
	app.use do flash

	app.set 'views', "#{__dirname}/../app/views"
	app.set 'views engine', 'jade'

