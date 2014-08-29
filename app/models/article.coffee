mongoose = require 'mongoose'
Schema = mongoose.Schema

ArticleSchema = new Schema
	title:
		type: String
		required: true
	description:
		type: String
		required: true
	link:
		type: String
		required: true
	tags:
		type: [String]
		required: true

module.exports = mongoose.model 'Article', ArticleSchema
