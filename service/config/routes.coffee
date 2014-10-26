passport = require 'passport'
express  = require 'express'
auth     = require '../controllers/auth.coffee'

module.exports = (app, passport) ->

	app.use '/', express.static "#{__dirname}/../public"

	app.post '/auth/local', auth.login 'local'

	app.get '/auth/github', passport.authenticate 'github'
	app.get '/auth/github/callback', auth.login 'github'

	app.get '/auth/google', passport.authenticate 'google', scope: ['profile', 'email']
	app.get '/auth/google/callback', auth.login 'google'

	app.get '/auth/facebook', passport.authenticate 'facebook'
	app.get '/auth/facebook/callback', auth.login 'facebook', scope: 'email'

	app.get '/auth/twitter', passport.authenticate 'twitter'
	app.get '/auth/twitter/callback', auth.login 'twitter'

	app.post '/user', (req, res) ->
		authenticated = do req.isAuthenticated
		if not authenticated
			return res.json
				error: 'Not authenticated'
		res.json req.user

	app.get '/logout', (req, res) ->
		do req.logout
		res.redirect '/'

	app.get '/login', (req, res) ->
		res.render 'login.jade', login_error: req.flash 'error'

	app.post '/register', auth.register
