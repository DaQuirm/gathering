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
		required: yes

module.exports = mongoose.model 'User', UserSchema
