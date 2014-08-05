
ArticleStash.views.AppView = (app) ->

	nxt.Element 'div',
		nxt.Attr 'style', 'display: flex; flex-grow: 1'
		ArticleStash.views.Articles app.articles
		ArticleStash.views.Digest app.digest
