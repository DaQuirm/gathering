ArticleCollection = require '../models/article-collection'
ArticleViewModel  = require './article-viewmodel'

class ArticlesViewModel

	constructor: ->
		@articles = new ArticleCollection item:ArticleViewModel
		do @articles.retrieve

		@article_form =  new nx.Cell value:new ArticleViewModel
		@form_collapsed = new nx.Cell value:yes

	save: ->
		article = @article_form.value
		[first] = @articles.items
		if first?
			@articles.insertBefore first, article
		else
			@articles.append article
		@articles.create article
		@article_form = new ArticleViewModel
		@form_collapsed.value = yes

	edit: (article) ->
		article.view.value = 'edit'

module.exports = ArticlesViewModel
