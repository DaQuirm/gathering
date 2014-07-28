BaseCRUDCtrl = require './base-crud.coffee'

success = (res) ->
	(content) ->
		if content
			res.send 200, content
		else
			res.send 404

failure = (res) ->
	(err) ->
		res.send 500

module.exports = class RestCtrl extends BaseCRUDCtrl
	constructor: (model) ->
		super model
		@Model = model

	create: (req, res) ->
		super req.body
			.then success(res), failure(res)

	read: (req, res) ->
		success = (content) ->
			if content and content.length > 0
				res.send 200, content
			else
				res.send 204

		super()
			.then success, failure(res)
