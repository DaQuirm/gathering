module.exports = (app, passport) ->

  # Pages
  index = require '../app/controllers/index.coffee'
  app.get '/', index.render

  register = require '../app/controllers/register.coffee'
  app.get '/register', register.render

  # Passport
  app.get '/auth/google', passport.authenticate('google')
  app.get '/auth/google/return', passport.authenticate('google', { successRedirect: '/register', failureRedirect: '/error' } )

  # Users
  users = require '../app/controllers/users.coffee'
  app.post '/users', users.create
  app.get '/users/:id', users.get

  # Restricted access resource
  restricted = require '../app/controllers/restricted.coffee'
  app.get '/restricted', restricted.test
