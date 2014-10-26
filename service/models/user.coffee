mongoose = require 'mongoose'

UserSchema = mongoose.Schema
	name:
		type: String
	first_name:
		type: String
	last_name:
		type: String
	email:
		type: String

publicify = ->
	name: @name
	first_name: @first_name
	last_name: @last_name
	email: @email

UserSchema.method
	publicify: publicify

module.exports = mongoose.model 'User', UserSchema
