Newsletter = require '../models/newsletter.coffee'
NewsletterArticle = require '../models/newsletter-article.coffee'
async = require 'async'

exports.create = (req, res) ->
	Newsletter.create req.body, (err, created) ->
		if err
			res.send 500
		else
			res.send 201, created

exports.read = (req, res) ->
	Newsletter.find().exec (err, found) ->
		if err
			res.send 500
		else
			populated_newsletters_count = 0
			if found.length
				for newsletter in found
					NewsletterArticle.populate newsletter, path:'articles', (err, populated) ->
						if err
							res.send 500
						else
							populated_newsletters_count++
							res.send 200, found if populated_newsletters_count is found.length
			else
				res.send 404

exports.get_by_id = (req, res) ->
	{id} = req.params
	Newsletter.findById id, (err, newsletter) ->
		if err or not newsletter
			res.send 404
		else
			res.send 200, newsletter

exports.update = (req, res) ->
	{id} = req.params
	updated = req.body
	articles_updated = no
	Newsletter.findById id, (err, newsletter) ->
		if err
			res.send 500
		else if not newsletter
			res.send 404
		else
			for property of updated
				if property is 'articles'
					articles_updated = yes
				newsletter[property] = updated[property]

			newsletter.markModified 'articles' if articles_updated
			newsletter.save (err) ->
				if err
					res.send 500
				res.send 200

exports.delete = (req, res) ->
	{id} = req.params
	Newsletter.findByIdAndRemove id, (err, newsletter) ->
		if err
			res.send 500
		else
			if not newsletter
				res.send 404
			else
				res.send 200

exports.parse = (req, res, next) ->

	saved_count = 0
	q = async.queue (article, done) ->
		NewsletterArticle.create article, (err, saved) ->
			done saved

	for article in req.body.articles
		q.push article, (saved) ->
			req.body.articles[saved_count] = saved._id
			saved_count++

	q.drain = ->
		do next
