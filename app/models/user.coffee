mongoose = require 'mongoose'

UserSchema = mongoose.Schema
	first_name:
		type: String
		required: true
	last_name:
		type: String
		required: true
	email:
		type: String
		required: true

module.exports = mongoose.model 'User', UserSchema
