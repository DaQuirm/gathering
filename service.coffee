# Dependencies
path     = require 'path'
express  = require 'express'
passport = require 'passport'
mongoose = require 'mongoose'
nconf    = require 'nconf'

# Configuration
require './config/config'

# MongoDB connection
mongoose.connect nconf.get 'mongodb:connection_string'
db = mongoose.connection
db.on 'error', console.error.bind console, 'connection error:'

# Express application
app = do express
require('./config/express') app, passport
require('./config/routes') app, passport

# Passport
(require './config/passport') passport

app.listen nconf.get 'service:port'

exports = module.exports = app
