# Dependencies
path     = require 'path'
express  = require 'express'
passport = require 'passport'
mongoose = require 'mongoose'
nconf    = require 'nconf'

app = do express

module.exports =

	app: app

	start: ->
		mongoose.connect nconf.get 'gathering:mongodb:connection_string'
		db = mongoose.connection
		db.on 'error', console.error.bind console, 'connection error:'

		require('./config/express') app, passport
		require('./config/routes') app, passport

		# Passport
		(require './config/passport') passport

		app.listen nconf.get 'gathering:service:port'


