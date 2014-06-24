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

event =
	title: 'Amazing EVENT'
	start_date: (new Date).getTime()
	venue: '10 Avenue B, New York, NY, United States'
	slots: [
		{
			type: 'talk'
			content: new ObjectId
		},{
			type: 'talk'
			content: new ObjectId
		},{
			type: 'break'
			content: 60000
		},{
			type: 'talk'
			content: new ObjectId
		},{
			type: 'talk'
			content: new ObjectId
		}
	]

event_with_invalid_slot_type =
	title: 'invalid EVENT'
	start_date: (new Date).getTime()
	venue: '10 Avenue B, New York, NY, United States'
	slots: [
		{
			type: 'invalid' # <- invalid, nothing else interesting here
			content: new ObjectId
		},{
			type: 'talk'
			content: new ObjectId
		},{
			type: 'break'
			content: 60000
		},{
			type: 'talk'
			content: new ObjectId
		},{
			type: 'talk'
			content: new ObjectId
		}
	]

event_with_invalid_slot_content =
	title: 'invalid EVENT'
	start_date: (new Date).getTime()
	venue: '10 Avenue B, New York, NY, United States'
	slots: [
		{
			type: 'talk'
			content: 'invalid content' # <- invalid, nothing else interesting here
		},{
			type: 'talk'
			content: new ObjectId
		},{
			type: 'break'
			content: 60000
		},{
			type: 'talk'
			content: new ObjectId
		},{
			type: 'talk'
			content: new ObjectId
		}
	]

updated_event = 
	title: 'Amazing EVENT updated'
	start_date: (new Date).getTime() + 60000
	venue: '10 Avenue C, New York, NY, United States'
	slots: [
		{
			type: 'talk'
			content: new ObjectId
		},{
			type: 'talk'
			content: new ObjectId
		},{
			type: 'break'
			content: 70000
		},{
			type: 'talk'
			content: new ObjectId
		},{
			type: 'talk'
			content: new ObjectId
		}
	]

exports.talk = talk
exports.invalid_talk = invalid_talk
exports.ObjectId = ObjectId
exports.updated_talk = updated_talk
exports.event = event
exports.updated_event = updated_event
exports.event_with_invalid_slot_type = event_with_invalid_slot_type
exports.event_with_invalid_slot_content = event_with_invalid_slot_content

exports.talks = (collection_length, callback) ->
	i = 0
	saved = 0
	talks = []

	while i < collection_length
		i++
		t = new models.Talk talk
		talks.push t
		t.save ->
			saved++
			callback talks if saved is collection_length

exports.events = (collection_length, callback) ->
	i = 0
	saved = 0
	events = []

	exports.talks collection_length * 4, (talks) ->
		while i < collection_length
			event =
				title: "Amazing EVENT ##{i}"
				start_date: (new Date).getTime() + i * 86400000
				slots: []
			j = 0
			while j < 4
				talk_id = talks[j]._id
				if j is 2
					event.slots.push
						type: 'break'
						content: 600000
				else
					event.slots.push
						type: 'talk'
						content: talk_id
				j++
			talks = talks.slice 4, talks.length
			ev = new models.Event event
			events.push ev
			ev.save ->
				saved++
				callback events if saved is collection_length
			i++
