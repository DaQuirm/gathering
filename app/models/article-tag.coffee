mongoose = require 'mongoose'
Schema = mongoose.Schema

ArticleTagSchema = new Schema
	name:
		type: String
		required: true
	score: Number
	respect: Number

module.exports = mongoose.model 'ArticleTag', ArticleTagSchema
