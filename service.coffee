# Dependencies
path           = require 'path'
express        = require 'express'
passport       = require 'passport'
mongoose       = require 'mongoose'

# MongoDB connection
mongoose.connect 'mongodb://localhost/test'
db = mongoose.connection
db.on 'error', console.error.bind console, 'connection error:'

# Passport
(require './config/passport') passport

# Models
require './app/models/user.coffee'

# Express application
app = do express
require('./config/express') app, passport
require('./config/routes') app, passport
app.listen 3000

exports = module.exports = app
