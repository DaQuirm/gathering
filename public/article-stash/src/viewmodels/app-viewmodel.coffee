{ArticlesViewModel} = ArticleStash.viewmodels

class AppViewModel

	constructor: ->
		@articles = new ArticlesViewModel

	render: (node) ->
		node.appendChild (ArticleStash.views.AppView @).data.node

ArticleStash.viewmodels.AppViewModel = AppViewModel
