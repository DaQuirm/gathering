Talk = require '../models/talk.coffee'

exports.create = (req, res) ->
	(new Talk req.body).save (err) ->
		if err
			res.send 500
		else
			res.send 200

exports.read = (req, res) ->
	Talk.find().exec (err, found) ->
		if err
			res.send 500
		else
			if found.length
				res.send 200, found
			else
				res.send 404

exports.getById = (req, res) ->
	{id} = req.params
	Talk.findById id, (err, item) ->
		if err or not item
			res.send 404
		else
			res.send 200, item

exports.update = (req, res) ->
	{id} = req.params
	Talk.findByIdAndUpdate id, req.body, (err, item) ->
		if err or not item
			res.send 404
		else
			res.send 200, item

exports.delete = (req, res) ->
	{id} = req.params
	Talk.findByIdAndRemove id, (err, item) ->
		if err
			res.send 500
		else
			if not item
				res.send 404
			else
				res.send 200
