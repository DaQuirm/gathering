mongoose = require 'mongoose'
Schema = mongoose.Schema

SlotSchema = new Schema
	type:
		type: String
		enum: ['talk', 'break']
	content: Schema.Types.Mixed

SlotSchema.pre 'save', (next) ->
	switch @type
		when 'talk'
			if @content not instanceof mongoose.Types.ObjectId
				return next new Error "Invalid content for slot type '#{@type}'"
		when 'break'
			if typeof @content isnt 'number'
				return next new Error "Invalid content for slot type '#{@type}'"
	do next

module.exports = SlotSchema
