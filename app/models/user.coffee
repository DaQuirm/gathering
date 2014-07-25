mongoose = require 'mongoose'

UserSchema = mongoose.Schema
	first_name:
		type: String
		required: yes
	last_name:
		type: String
		required: yes
	email:
		type: String

publicify = ->
	first_name: @first_name
	last_name: @last_name
	email: @email

UserSchema.method
	publicify: publicify

module.exports = mongoose.model 'User', UserSchema
