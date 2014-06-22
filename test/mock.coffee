mongoose = require 'mongoose'
models = require './../app/models/'

ObjectID = require('mongoose').Types.ObjectId

authors = [new ObjectID, new ObjectID]

talk =
	theme: 'Talk theme'
	duration: 600000
	authors: authors

updatedTalk =
	theme: 'Talk theme 2'
	duration: 1200000
	authors: authors

crap =
	talk:
		theme: 'Talk theme'
		duration: 600000
		authors: [1,2,3]
		crap: 'crap'


exports.talk = talk
exports.crap = crap
exports.ObjectID = ObjectID
exports.updatedTalk = updatedTalk

exports.talks = (collectionLength, callback) ->

	i = 0
	saved = 0

	talks = []

	while i < collectionLength

		i++

		t = new models.Talk talk
		t.save () ->
			saved++
			talks.push t
			callback talks if saved is collectionLength
