newsletter_articles = require '../app/controllers/newsletter-article.coffee'
express             = require 'express'


module.exports = (app) ->

	app.use '/apps/', express.static "#{__dirname}/../public"

	app.get '/articles', newsletter_articles.read
	app.post '/articles', newsletter_articles.create
