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
					for slot in event.slots when slot.type is 'talk'
							talks_count++
							Talk.populate slot, path: 'content', (err, populated_slot) ->
								if err
									res.send 500
								populated_talks_count++
								if populated_slot and populated_talks_count is talks_count
									res.send 200, found
			else
				res.send 404

exports.get_by_id = (req, res) ->
	{id} = req.params
	Event.findById id, (err, event) ->
		if err or not event
			res.send 404
		else
			res.send 200, event

exports.update = (req, res) ->
	{id} = req.params
	updated = req.body
	slots_updated = no
	Event.findById id, (err, event) ->
		if err
			res.send 500
		else if not event
			res.send 404
		else
			for property of updated
				if property is 'slots'
					slots_updated = yes
				event[property] = updated[property]

			event.markModified 'slots' if slots_updated
			event.save (err) ->
				if err
					res.send 500
				res.send 200

exports.delete = (req, res) ->
	{id} = req.params
	Event.findByIdAndRemove id, (err, event) ->
		if err
			res.send 500
		else
			if not event
				res.send 404
			else
				res.send 200
