mongoose = require 'mongoose'

providers = [
	'facebook'
	'google'
	'twitter'
	'github'
]

AccountSchema = new mongoose.Schema
	emails:
		type: [String]
	provider:
		type: String
		enum: providers
		required: yes
	provider_id:
		type: String
		required: yes
	user:
		type: mongoose.Schema.Types.ObjectId
		ref: 'User'
		required: yes


module.exports = mongoose.model 'Account', AccountSchema
