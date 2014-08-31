ArticleFormView = require './article-form-view'
ArticleView     = require './article-view'
ArticleEditView = require './article-edit-view'

module.exports = (context) ->

	nxt.Element 'div',
		nxt.Class 'block-left', true
			ArticleFormView context, context.article_form

		nxt.Element 'ul',
			nxt.Class 'articles-list'
			nxt.Collection context.articles, (article) ->
				nxt.Element 'li',
					nxt.Binding article.view, (view) ->
						switch view
							when 'item'
								ArticleView article
							when 'edit'
								ArticleEditView article
					nxt.Event 'click', ({target}) ->
						if target.matches 'li.remove'
							context.articles.remove article
						else if target.matches 'li.edit'
							context.edit article
