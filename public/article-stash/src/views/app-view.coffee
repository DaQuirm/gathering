ArticlesView = require './articles-view.coffee'
DigestView   = require './digest-view.coffee'

module.exports = (app) ->
	nxt.Element 'div',
		nxt.Attr 'style', 'display: flex; flex-grow: 1'
		ArticlesView app.articles
		DigestView app.digest
