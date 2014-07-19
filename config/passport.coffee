mongoose       = require 'mongoose'
GoogleStrategy = require('passport-google').Strategy
LocalStrategy = require('passpot-local').Strategy
LocalAccount = require('../app/models/local-account')

module.exports = (passport) ->

		passport.serializeUser (user, done) ->
			done null, user

		passport.deserializeUser (obj, done) ->
			done null, obj

		passport.use new GoogleStrategy {
				returnURL: 'http://localhost:3000/auth/google/return'
				realm: 'http://localhost:3000/'
			},
			(identifier, profile, done) ->
				done null, profile

		passport.use new LocalStrategy
			usernameField: 'email'
			passwordField: 'password',
			(email, password, done) ->
				LocalAccount.findOne email:email, (err, account) ->
					return done err if err or not account
					if not account.authenticate password
							done null, false
					else
							done null, account.user
