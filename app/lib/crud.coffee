
module.exports = class BaseCRUDCtrl
	constructor: (model) ->
		@Model = model

	create: (document) ->
		@Model.create document

	read: ->
		@Model.find().exec()

	get_by_id: (id) ->
		@Model.findById id
			.exec()
