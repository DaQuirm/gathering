body_parser = require 'body-parser'
express     = require 'express'

module.exports = (app) ->
	app.use do body_parser.json

