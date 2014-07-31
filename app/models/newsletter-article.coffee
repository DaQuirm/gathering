mongoose = require 'mongoose'
Schema = mongoose.Schema
Tag = require 'article-tag.coffee'

NewsletterArticleSchema = new Schema
	title: String
	description: String
	link: String
	tags: [Tag]

module.exports = mongoose.model 'NewsletterArticle', NewsletterArticleSchema
