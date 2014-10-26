express       = require 'express'
cookie_parser = require 'cookie-parser'
body_parser   = require 'body-parser'
session       = require 'express-session'
flash         = require 'express-flash'
nconf         = require 'nconf'

module.exports = (app, passport) ->
	app.use do cookie_parser
	app.use do body_parser.json
	app.use body_parser.urlencoded extended:no
	app.use session nconf.get 'gathering:session'
	app.use do passport.initialize
	app.use do passport.session
	app.use do flash

