NewsletterArticle = require '../models/newsletter-article.coffee'

exports.create = (req, res) ->
	console.log req.body
	NewsletterArticle.create req.body, (err, created) ->
		if err
			res.send 500
		else
			res.send 200, created

exports.read = (req, res) ->
	NewsletterArticle.find().exec (err, found) ->
		if err
			res.send 500
		else
			if found.length
				res.send 200, found
			else
				res.send 404

exports.get_by_id = (req, res) ->
	{id} = req.params
	NewsletterArticle.findById id, (err, item) ->
		if err or not item
			res.send 404
		else
			res.send 200, item

exports.update = (req, res) ->
	{id} = req.params
	NewsletterArticle.findByIdAndUpdate id, req.body, (err, item) ->
		if err or not item
			res.send 404
		else
			res.send 200, item

exports.delete = (req, res) ->
	{id} = req.params
	NewsletterArticle.findByIdAndRemove id, (err, item) ->
		if err
			res.send 500
		else
			if not item
				res.send 404
			else
				res.send 200
