mongoose = require 'mongoose'
Schema = mongoose.Schema

NewsletterArticleSchema = new Schema
	title: String
	description: String
	link: String
	tags: [String]

module.exports = mongoose.model 'NewsletterArticle', NewsletterArticleSchema
