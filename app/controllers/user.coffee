User = require '../models/user.coffee'

exports.create = (req, res) ->
	(new User req.body).save (err) ->
		if err
			res.send 500
		else
			res.send 200

exports.read = (req, res) ->
	User.find().exec (err, found) ->
		if err
			res.send 500
		else
			if found.length
				res.send 200, found
			else
				res.send 404

exports.get_by_id = (req, res) ->
	{id} = req.params
	User.findById id, (err, item) ->
		if err or not item
			res.send 404
		else
			res.send 200, item

exports.update = (req, res) ->
	{id} = req.params
	User.findByIdAndUpdate id, req.body, (err, item) ->
		if err or not item
			res.send 404
		else
			res.send 200, item

exports.delete = (req, res) ->
	{id} = req.params
	User.findByIdAndRemove id, (err, item) ->
		if err
			res.send 500
		else
			if not item
				res.send 404
			else
				res.send 200


