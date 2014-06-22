mongoose = require 'mongoose'
Schema = mongoose.Schema

TalkSchema = new Schema
	duration: Number
	theme: String
	authors: [
		type: Schema.Types.ObjectId
		ref: 'User'
	]

module.exports = mongoose.model 'Talk', TalkSchema
