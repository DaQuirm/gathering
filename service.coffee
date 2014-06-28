path     = require 'path'
express  = require 'express'
passport = require 'passport'
mongoose = require 'mongoose'

mongoose.connect 'mongodb://localhost/gathering'
db = mongoose.connection
db.on 'error', console.error.bind console, 'connection error:'

app = do express

require('./config/express.coffee') app

app.listen 3000
