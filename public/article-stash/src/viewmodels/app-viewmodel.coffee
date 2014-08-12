ArticlesViewModel = require './articles-viewmodel.coffee'
AppView           = require '../views/app-view.coffee'

class AppViewModel

	constructor: ->
		@articles = new ArticlesViewModel

	render: (node) ->
		node.appendChild (AppView @).data.node

module.exports = AppViewModel
