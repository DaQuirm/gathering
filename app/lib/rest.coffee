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
		found = (content) ->
			if content and content.length > 0
				res.send 200, content
			else
				res.send 204

		super()
			.then found, failure(res)

	get_by_id: (req, res) ->
		super req.params.id
			.then success(res), failure(res)

	update: (req, res) ->
		super req.params.id, req.body
			.then success(res), failure(res)

	delete: (req, res) ->
		super req.params.id
			.then success(res), failure(res)
