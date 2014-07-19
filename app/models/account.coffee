mongoose = require 'mongoose'
User = require 'user'

providers = [
	'facebook'
	'google'
	'twitter'
]

AccountSchema = new mongoose.Schema
	emails:
		type: [String]
		required: no
	provider:
		type: String
		enum: providers
		required: yes
	id:
		type: String
		required: yes
	user:
		type: User
		required: yes


module.exports = mongoose.model 'Account', AccountSchema
