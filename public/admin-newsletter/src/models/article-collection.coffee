{Article} = Newsletter.models

class ArticleCollection extends nx.RestCollection
	constructor: ->
		super
			url: '/articles'
			item: Article

Newsletter.models.ArticleCollection = ArticleCollection
