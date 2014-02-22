module.exports = (app, passport) ->

  # Pages
  index = require '../app/controllers/index'
  app.get '/', index.render

  register = require '../app/controllers/register'
  app.get '/register', register.render

  # Passport
  app.get '/auth/google', passport.authenticate('google')
  app.get '/auth/google/return', passport.authenticate('google', { successRedirect: '/register', failureRedirect: '/error' } )

  # Users
  users = require '../app/controllers/users'
  app.post '/users', users.create
  app.get '/users/:id', users.get

  # Restricted access resource
  restricted = require '../app/controllers/restricted'
  app.get '/restricted', restricted.test
