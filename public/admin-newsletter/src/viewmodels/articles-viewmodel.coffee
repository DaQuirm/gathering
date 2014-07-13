{ArticleCollection, Article} = Newsletter.models

class ArticlesViewModel

	constructor: ->
		@articles = new ArticleCollection
		do @articles.retrieve

		@new_article = new Article

	save: (article) ->
		console.log article
		[first] = @articles.items
		if first
			@articles.items.insertBefore first, article
		else
			@articles.items.append article
		# @articles.create article

Newsletter.viewmodels.ArticlesViewModel = ArticlesViewModel
