
ArticleStash.views.AppView = (app) ->

	nxt.Element 'main',
		ArticleStash.views.Articles app.articles
