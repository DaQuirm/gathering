passport     = require 'passport'

LocalAccount = require '../models/local-account.coffee'
Account      = require '../models/account.coffee'
User         = require '../models/user.coffee'


oauth_login = (strategy_name) ->
	(req, res, next) ->
		passport.authenticate(strategy_name, (err, user, info) ->
			if err
				req.session.auth_error = err
				return res.redirect "/apps/#{req.session.app_name}"
			unless user
				req.session.auth_error = message:'user not found'
				return res.redirect "/apps/#{req.session.app_name}"
			req.logIn user, (err) ->
				req.session.auth_error = err if err
				res.redirect "/apps/#{req.session.app_name}"
		) req, res, next


login_action =
	local: (req, res, next) ->
		passport.authenticate('local', (err, user, info) ->
			if err
				res.json error:err
			return res.json error:'Invalid login or password' unless user
			req.logIn user, (err) ->
				res.json error:err if err
				res.json
					user: do user.publicify
					error: null
		) req, res, next

	github: oauth_login 'github'
	google: oauth_login 'google'
	facebook: oauth_login 'facebook'
	twitter: oauth_login 'twitter'

exports.login = (strategy_name) -> login_action[strategy_name]
exports.register = (req, res) ->
	{email, password} = req.body
	User.create(email:email).exec (err, created) ->
		if err or not created
			return res.json error:true
		LocalAccount.create
			email: email
			password: password
			user: created._id,
			(err, created) ->
				if err or not created
					return res.json error:true
				res.json
					user: user
					error: null

