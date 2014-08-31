ArticleCollection = require '../models/article-collection'
Article           = require '../models/article'
ArticleDraft      = require './article-draft'

class ArticlesViewModel

	constructor: ->
		@articles = new ArticleCollection
		do @articles.retrieve

		@new_article = new ArticleDraft

	save: (article_data) ->
		article = new Article data:article_data
		[first] = @articles.items
		if first
			@articles.insertBefore first, article
		else
			@articles.append article
		@articles.create article
		do @new_article.reset

module.exports = ArticlesViewModel
