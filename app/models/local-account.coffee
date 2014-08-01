mongoose = require 'mongoose'
Schema = mongoose.Schema
User = require './user.coffee'
passport = require 'passport'
bcrypt = require 'bcrypt-nodejs'

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
		salt = do bcrypt.genSaltSync
		bcrypt.hash @password, salt, null, (err, hash) =>
			if hash
				@password = hash
				do done
			else
				done err

match_password = (password) ->
	bcrypt.compareSync password, @password

LocalAccountSchema.method
	match_password: match_password

module.exports = mongoose.model 'LocalAccount', LocalAccountSchema
