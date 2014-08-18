ArticlesView = require './articles-view'
DigestView   = require './digest-view'

module.exports = (app) ->
	nxt.Element 'div',
		nxt.Attr 'style', 'display: flex; flex-grow: 1'
		ArticlesView app.articles
		DigestView app.digest
