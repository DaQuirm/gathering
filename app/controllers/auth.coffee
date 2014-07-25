passport     = require 'passport'

LocalAccount = require '../models/local-account.coffee'
Account      = require '../models/account.coffee'
User         = require '../models/user.coffee'


oauth_login = (strategy_name) ->
	(req, res, next) ->
		passport.authenticate(strategy_name, (err, user, info) ->
			return next err if err
			return res.send error:'Invalid login or password' unless user
			req.logIn user, (err) ->
				return next err if err
				res.redirect '/apps/auth-proto'
		) req, res, next


login_action =
	local: (req, res, next) ->
		passport.authenticate('local', (err, user, info) ->
			return next err if err
			return res.send error:'Invalid login or password' unless user
			req.logIn user, (err) ->
				return next err if err
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

