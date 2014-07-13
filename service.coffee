express  = require 'express'
mongoose = require 'mongoose'

mongoose.connect 'mongodb://localhost/gathering'
db = mongoose.connection
db.on 'error', console.error.bind console, 'connection error:'

app = do express

require('./config/express.coffee') app
require('./config/routes.coffee') app

app.listen 3000
