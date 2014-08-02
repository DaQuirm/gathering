mongoose = require 'mongoose'
Schema = mongoose.Schema
User = require './user.coffee'
passport = require 'passport'
bcrypt = require 'bcrypt'

LocalAccountSchema = new mongoose.Schema
	email:
		type: String
		required: yes
	password:
		type: String
		required: yes
	user:
		type: Schema.Types.ObjectId
		ref: 'User'
		required: yes

LocalAccountSchema.pre 'save', (done) ->
	unless @isNew
		do done
	else
		bcrypt.hash @password, 8, (err, hash) =>
			if err?
				done err
			else
				@password = hash
				do done

LocalAccountSchema.methods =
	match_password: (password, done) ->
		bcrypt.compare password, @password, done

module.exports = mongoose.model 'LocalAccount', LocalAccountSchema
