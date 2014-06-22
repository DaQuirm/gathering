mongoose = require 'mongoose'
models = require './../app/models/'

ObjectID = require('mongoose').Types.ObjectId

authors = [new ObjectID, new ObjectID]

talk =
	theme: 'Talk theme'
	duration: 600000
	authors: authors

updated_talk =
	theme: 'Talk theme 2'
	duration: 1200000
	authors: authors

invalid_talk =
	talk:
		theme: 'Talk theme'
		duration: 600000
		authors: [1,2,3]
		trash: 'trash'


exports.talk = talk
exports.invalid_talk = invalid_talk
exports.ObjectID = ObjectID
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
