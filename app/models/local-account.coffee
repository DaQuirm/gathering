mongoose = require 'mongoose'
User = require 'user'

LocalAccountSchema = new mongoose.Schema
	email:
		type: String
		required: yes
	password:
		type: String
		required: yes
	user:
		type: User
		required: yes


module.exports = mongoose.model 'LocalAccount', LocalAccountSchema
