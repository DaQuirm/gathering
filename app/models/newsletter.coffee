mongoose = require 'mongoose'
Schema = mongoose.Schema

NewsletterSchema = new Schema
	date: Date
	articles: [
		type: Schema.ObjectId
		ref: 'NewsletterArticle'
	]

module.exports = mongoose.model 'Newsletter', NewsletterSchema
