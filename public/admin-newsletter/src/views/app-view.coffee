
Newsletter.views.AppView = (app) ->

	nxt.Element 'main',
		Newsletter.views.Articles app.articles
