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

