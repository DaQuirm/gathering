Article = require './article'

class ArticleCollection extends nx.RestCollection
	constructor: ->
		super
			url: '/api/articles'
			item: Article

module.exports = ArticleCollection
