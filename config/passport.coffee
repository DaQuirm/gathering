FacebookStrategy = require('passport-facebook').Strategy
TwitterStrategy  = require('passport-twitter').Strategy
GoogleStrategy   = require('passport-google-oauth').OAuth2Strategy;
GitHubStrategy   = require('passport-github').Strategy
LocalStrategy    = require('passport-local').Strategy
LocalAccount     = require '../app/models/local-account'
mongoose         = require 'mongoose'
Account          = require '../app/models/account.coffee'
User             = require '../app/models/user.coffee'

parse_profile = (profile) ->
	account =
		provider: profile.provider
		provider_id: do profile.id.toString

	user = {}

	if 'emails' of profile
		account.emails = profile.emails.map (item) -> item = item.value
		user.email = account.emails[0]

	if profile.provider is 'github' or 'twitter'
		[name, user.first_name, user.last_name] = profile.displayName.match /(\S*)\s*(.*)/
	else
		user.first_name = profile.name.givenName
		user.last_name = profile.name.familyName

	account: account
	user: user

oauth_authenticate = (accessToken, refreshToken, profile, done) ->
	{account, user} = parse_profile profile
	Account.findOne
		provider: profile.provider
		provider_id: do profile.id.toString,
		(err, found) ->
			return done err if err
			if found
				User.populate found, path:'user', (err, populated) ->
					if err
						done err
					if populated
						done null, populated.user
			else
				User.create user, (err, user) ->
					return done err if err or not user
					account.user = user._id
					Account.create account, (err, account) ->
						return done err if err
						done null, user


module.exports = (passport) ->

	passport.serializeUser (user, done) ->
		done null, do user.publicify

	passport.deserializeUser (user, done) ->
		done null, user

	passport.use new GoogleStrategy
		clientID: '312119867391-77cfq0v5cegqkqtg11irmi0o6big7gqt.apps.googleusercontent.com'
		clientSecret: 'yfCIJmtG9YA1_FOFoVyrEtTM'
		callbackURL: 'http://127.0.0.1:3000/auth/google/callback',
		oauth_authenticate

	passport.use new GitHubStrategy
		clientID: '1fc46b1a169447b9479f'
		clientSecret: 'b9eb6728663f79e3a30092a53af66b463fcc3886'
		callbackURL: 'http://127.0.0.1:3000/auth/github/callback',
		oauth_authenticate

	passport.use new FacebookStrategy
		clientID: '607413499378842'
		clientSecret: '54fd4d2e3f7819dc0f8120bc514fa437'
		callbackURL: 'http://localhost:3000/auth/facebook/callback',
		oauth_authenticate

	passport.use new TwitterStrategy
		consumerKey: 'KPVReIlwhp4Uk7SYvT0oXeCzT'
		consumerSecret: 'M9qLYNFB2BMTZbILQsgBqDaez2Q8gJhRPFqYpLQuh7W0GphUYP'
		callbackURL: 'http://127.0.0.1:3000/auth/twitter/callback',
		oauth_authenticate

	passport.use new LocalStrategy
		usernameField: 'email'
		passwordField: 'password',
		(email, password, done) ->
			LocalAccount.findOne email:email, (err, account) ->
				return done err if err or not account
				if not account.match_password password
					done null, false
				else
					User.populate account, path:'user', (err, populated) ->
						if err
							done err
						if populated
							done null, populated.user
