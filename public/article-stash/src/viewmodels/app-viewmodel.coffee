ArticlesViewModel = require './articles-viewmodel'
AppView           = require '../views/app-view'

class AppViewModel

	constructor: ->
		@articles = new ArticlesViewModel

	render: (node) ->
		node.appendChild (AppView @).data.node

module.exports = AppViewModel
