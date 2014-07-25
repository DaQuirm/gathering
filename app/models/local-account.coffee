mongoose = require 'mongoose'
Schema = mongoose.Schema
User = require './user.coffee'
passport = require 'passport'

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

match_password = (password) ->
	return no if @password isnt password
	yes

LocalAccountSchema.method
	match_password: match_password

module.exports = mongoose.model 'LocalAccount', LocalAccountSchema
