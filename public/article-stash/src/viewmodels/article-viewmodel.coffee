Article = require '../models/article.coffee'

class ArticleViewModel extends Article
	constructor: ->
		super
		@view = new nx.Cell value:'item'

module.exports = ArticleViewModel
