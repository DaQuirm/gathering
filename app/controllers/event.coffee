Event = require '../models/event.coffee'

exports.create = (req, res) ->
	(new Event req.body).save (err) ->
		if err
			res.send 500
		else
			res.send 200
