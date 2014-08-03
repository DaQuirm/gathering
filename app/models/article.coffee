mongoose = require 'mongoose'
Schema = mongoose.Schema

ArticleSchema = new Schema
	title: String
	description: String
	link: String
	tags: [String]

module.exports = mongoose.model 'Article', ArticleSchema
