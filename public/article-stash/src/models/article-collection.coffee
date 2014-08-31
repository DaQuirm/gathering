Article = require './article'

class ArticleCollection extends nx.RestCollection
	constructor: (options) ->
		super
			url: '/api/articles'
			item: options.item or Article

module.exports = ArticleCollection
