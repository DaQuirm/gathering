passport     = require 'passport'

LocalAccount = require '../models/local-account.coffee'
Account      = require '../models/account.coffee'
User         = require '../models/user.coffee'


oauth_login = (strategy_name) ->
	(req, res, next) ->
		passport.authenticate(strategy_name, (err, user, info) ->
			if err
				req.session.auth_error = err
				return res.redirect '/'
			unless user
				req.session.auth_error = message:'user not found'
				return res.redirect '/'
			req.logIn user, (err) ->
				req.session.auth_error = err if err
				res.redirect '/'
		) req, res, next


login_action =
	local: passport.authenticate 'local',
			successRedirect: '/'
			failureRedirect: '/login'
			failureFlash: 'Invalid email or password'

	github: oauth_login 'github'
	google: oauth_login 'google'
	facebook: oauth_login 'facebook'
	twitter: oauth_login 'twitter'

exports.login = (strategy_name) -> login_action[strategy_name]
exports.register = (req, res) ->
	{email, password, name} = req.body
	LocalAccount.findOne email: email
		.exec()
		.then (found) ->

			if found
				req.flash 'error', 'User exists'
				return res.render 'login.jade', error: req.flash 'error'

			create = User.create
				email:email
				name: name

			create.then (created) ->

				if not created
					res.json error:true

				LocalAccount.create
					email: email
					password: password
					user: created._id,
					(err, created) ->
						if err or not created
							return res.json error:true
						res.redirect '/login'

