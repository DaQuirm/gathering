mongoose = require 'mongoose'
models = require './../app/models/'

{ObjectId} = require('mongoose').Types

authors = [new ObjectId, new ObjectId]

talk =
	topic: 'Talk topic'
	duration: 600000
	authors: authors

updated_talk =
	topic: 'Talk topic 2'
	duration: 1200000
	authors: authors

invalid_talk =
	talk:
		topic: 'Talk topic'
		duration: 600000
		authors: [1,2,3]
		trash: 'trash'


exports.talk = talk
exports.invalid_talk = invalid_talk
exports.ObjectId = ObjectId
exports.updated_talk = updated_talk

exports.talks = (collection_length, callback) ->
	i = 0
	saved = 0
	talks = []

	while i < collection_length
		i++
		t = new models.Talk talk
		t.save () ->
			saved++
			talks.push t
			callback talks if saved is collection_length
