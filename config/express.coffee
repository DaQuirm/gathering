express = require 'express'
stylus =  require 'stylus'

module.exports = (app, passport) ->

  app.use express.static('./public')

  app.set 'views', './app/views'
  app.set 'view engine', 'jade'

  app.configure ->
    app.use express.cookieParser('secret')
    app.use express.bodyParser()
    app.use express.session()
    app.use passport.initialize()
    app.use passport.session()
    app.use stylus.middleware('./public')
