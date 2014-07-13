passport = require 'passport'
express  = require 'express'
auth     = require '../app/controllers/auth.coffee'

module.exports = (app, passport) ->

  # Pages
  index = require '../app/controllers/index.coffee'
  app.get '/', index.render

	app.get '/apps/:app_name', (req, res, next) ->
		req.session.app_name = req.params.app_name
		do next

	app.use '/apps/', express.static "#{__dirname}/../public"

	app.post '/auth/local', auth.login 'local'

	app.get '/auth/github', passport.authenticate 'github'
	app.get '/auth/github/callback', auth.login 'github'

	app.get '/auth/google', passport.authenticate 'google', scope: ['profile', 'email']
	app.get '/auth/google/callback', auth.login 'google'

	app.get '/auth/facebook', passport.authenticate 'facebook'
	app.get '/auth/facebook/callback', auth.login 'facebook', scope: 'email'

	app.get '/auth/twitter', passport.authenticate 'twitter'
	app.get '/auth/twitter/callback', auth.login 'twitter'

	app.get '/user', (req, res) ->
		res.send req.user

	app.get '/logout', (req, res) ->
		do req.logout
		res.redirect "/apps/#{req.session.app_name}"
