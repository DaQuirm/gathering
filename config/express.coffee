express       = require 'express'
cookie_parser = require 'cookie-parser'
body_parser   = require 'body-parser'
session       = require 'express-session'

module.exports = (app, passport) ->
	app.use express.static('./public')
	app.use do cookie_parser
	app.use do body_parser.json
	app.use session secret:'cellar door'
	app.use do passport.initialize
	app.use do passport.session
