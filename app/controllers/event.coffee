Event = require '../models/event.coffee'
Talk = require '../models/talk.coffee'

exports.create = (req, res) ->
	(new Event req.body).save (err) ->
		if err
			res.send 500
		else
			res.send 200

exports.read = (req, res) ->
	Event.find().exec (err, found) ->
		if err
			res.send 500
		else
			talks_count = 0
			populated_talks_count = 0
			if found.length
				for event in found
					for slot in event.slots
						if slot.type is 'talk'
							talks_count++
							Talk.populate slot, path: 'content', (err, populated_slot) ->
								if err
									res.send 500
								populated_talks_count++
								if populated_event and populated_talks_count is talks_count
									res.send 200, found
			else
				res.send 404
