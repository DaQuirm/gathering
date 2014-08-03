{ArticleCollection, Article} = ArticleStash.models

class ArticlesViewModel

	constructor: ->
		@articles = new ArticleCollection
		do @articles.retrieve

		@new_article = new Article

	save: (article) ->
		[first] = @articles.items.items
		if first
			@articles.items.insertBefore first, article
		else
			@articles.items.append article
		@articles.create article

ArticleStash.viewmodels.ArticlesViewModel = ArticlesViewModel
