{Article} = ArticleStash.models

class ArticleCollection extends nx.RestCollection
	constructor: ->
		super
			url: '/api/articles'
			item: Article

ArticleStash.models.ArticleCollection = ArticleCollection
