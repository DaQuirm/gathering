mongoose = require 'mongoose'
Schema = mongoose.Schema

TalkSchema = new Schema
	duration:
		type: Number
		required: yes
	topic:
		type: String
		required: yes
	authors: [
		type: Schema.Types.ObjectId
		ref: 'User'
		required: yes
	]

module.exports = mongoose.model 'Talk', TalkSchema
