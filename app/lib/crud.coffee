
module.exports = class BaseCRUDCtrl
	constructor: (model) ->
		@Model = model

	create: (document) ->
		@Model.create document
