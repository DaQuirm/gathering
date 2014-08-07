{ArticleCollection, Article} = ArticleStash.models
{ArticleDraft} = ArticleStash.viewmodels

class ArticlesViewModel

	constructor: ->
		@articles = new ArticleCollection
		do @articles.retrieve

		@new_article = new ArticleDraft

	save: (article) ->
		[first] = @articles.items.items
		if first
			@articles.items.insertBefore first, article
		else
			@articles.items.append article
		@articles.create article
		do @new_article.reset

ArticleStash.viewmodels.ArticlesViewModel = ArticlesViewModel
