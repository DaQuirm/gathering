sinon = require 'sinon'
sinon_chai = require 'sinon-chai'
chai = require 'chai'

should = do chai.should
chai.use sinon_chai

NewsletterArticles = require '../app/controllers/newsletter-article.coffee'
NewsletterArticle = require '../app/models/newsletter-article.coffee'

mock = require './mock.coffee'

do require './db.coffee'


describe 'NewsletterArticle', ->

	describe '#create', ->
		it 'saves new newsletter_article to newsletter_articles collection', (done) ->
			req =
				body: mock.newsletter_article
			res =
				send: ->
					spy.should.have.been.calledOnce
					spy.should.have.been.calledWith 200
					NewsletterArticle.find().exec (err, newsletter_articles) ->
						should.not.exist err
						should.exist newsletter_articles
						do done
			spy = sinon.spy res, 'send'
			NewsletterArticles.create req, res


	describe '#read', ->
		it 'gets all newsletter articles', (done) ->
			length = 10
			mock.newsletter_articles length, ->
				req = {}
				res =
					send: ->
						spy.should.have.been.calledOnce
						spy.should.have.been.calledWith 200
						NewsletterArticle.find().exec (err, newsletter_articles) ->
							should.not.exist err
							newsletter_articles.length.should.equal length
							spy.args[0][1].length.should.equal newsletter_articles.length
							do done
				spy = sinon.spy res, 'send'
				NewsletterArticles.read req, res

		it 'sends 204 if newsletter_articles collection is empty', (done) ->
			req = {}
			res =
				send: ->
					spy.should.have.been.calledOnce
					spy.should.have.been.calledWith 204
					do done
			spy = sinon.spy res, 'send'
			NewsletterArticles.read req, res

	describe '#get_by_id', ->
		it 'gets newsletter_article by id', (done) ->
			mock.newsletter_articles 10, (newsletter_articles) ->
				id = newsletter_articles[2]._id
				req =
					params:
						id: id
				res =
					send: ->
						spy.should.have.been.calledOnce
						spy.should.have.been.calledWith 200
						NewsletterArticle.findById id, (err, newsletter_article) ->
							spy.args[0][1].should.exist
							do done
				spy = sinon.spy res, 'send'
				NewsletterArticles.get_by_id req, res

		it 'sends 404 if newsletter_article is not found', (done) ->
			id = new mock.ObjectId
			req =
				params:
					id: id
			res =
				send: ->
					spy.should.have.been.calledOnce
					spy.should.have.been.calledWith 404
					do done
			spy = sinon.spy res, 'send'
			NewsletterArticles.get_by_id req, res

	describe '#update', ->
		it 'updates item', (done) ->
			mock.newsletter_articles 10, (newsletter_articles) ->
				id = newsletter_articles[2]._id
				expected = mock.updated_newsletter_article
				req =
					params:
						id: id
					body: mock.updated_newsletter_article
				res =
					send: ->
						spy.should.have.been.calledOnce
						spy.should.have.been.calledWith 200
						expected.title.should.equal spy.args[0][1].title
						expected.link.should.equal spy.args[0][1].link
						expected.description.should.equal spy.args[0][1].description
						for i in [0..expected.tags]
							expected.tags[i].should.equal spy.args[0][1].tags[i]
						do done
				spy = sinon.spy res, 'send'
				NewsletterArticles.update req, res

		it 'sends 404 if newsletter_article to update is not found', (done) ->
			id = new mock.ObjectId
			req =
				params:
					id: id
			res =
				send: ->
					spy.should.have.been.calledOnce
					spy.should.have.been.calledWith 404
					do done
			spy = sinon.spy res, 'send'
			NewsletterArticles.update req, res

	describe '#delete', ->
		it 'deletes item', (done) ->
			mock.newsletter_articles 10, (newsletter_articles) ->
				id = newsletter_articles[2]._id
				req =
					params:
						id: id
				res =
					send: ->
						spy.should.have.been.calledOnce
						spy.should.have.been.calledWith 200
						NewsletterArticle.findById id, (err, newsletter_article) ->
							should.not.exist newsletter_article
							do done
				spy = sinon.spy res, 'send'
				NewsletterArticles.delete req, res

		it 'sends 404 if newsletter_article to delete is not found', (done) ->
			id = new mock.ObjectId
			req =
				params:
					id: id
			res =
				send: ->
					spy.should.have.been.calledOnce
					spy.should.have.been.calledWith 404
					do done
			spy = sinon.spy res, 'send'
			NewsletterArticles.delete req, res
