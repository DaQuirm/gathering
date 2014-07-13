{ArticlesViewModel} = Newsletter.viewmodels

class AppViewModel

	constructor: ->
		@articles = new ArticlesViewModel

	render: (node) ->
		node.appendChild (Newsletter.views.AppView @).node

Newsletter.viewmodels.AppViewModel = AppViewModel
