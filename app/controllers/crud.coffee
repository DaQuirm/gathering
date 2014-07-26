
module.exports = (Model) ->

	success = (res) ->
		(content) ->
			if content and content.length isnt 0
				res.send 200, content
			else
				res.send 404

	fail = (res) ->
		->
			res.send 500

	crud =
		create : (req, res) ->

			created = (created) ->
				res.send 200, created

			Model.create(req.body)
				.then created, fail res

		read : (req, res) ->
			Model.find()
				.exec()
				.then success(res), fail(res)


		get_by_id : (req, res) ->
			{id} = req.params
			Model.findById id
				.exec()
				.then success(res), fail(res)

		update : (req, res) ->
			{id} = req.params
			Model.findByIdAndUpdate id, req.body
				.exec()
				.then success(res), fail(res)

		delete : (req, res) ->
			{id} = req.params
			Model.findByIdAndRemove id
				.exec()
				.then success(res), fail(res)
