Article = require './article.coffee'

class ArticleCollection extends nx.RestCollection
	constructor: ->
		super
			url: '/api/articles'
			item: Article

module.exports = ArticleCollection
