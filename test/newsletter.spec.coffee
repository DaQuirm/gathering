sinon = require 'sinon'
sinon_chai = require 'sinon-chai'
chai = require 'chai'

should = do chai.should
chai.use sinon_chai

NewsletterController = require '../app/controllers/newsletter.coffee'
Newsletter = require '../app/models/newsletter.coffee'

mock = require './mock.coffee'

do require './db.coffee'

o = 0 # I'm so sorry, to many typos when zero

describe 'Newsletter', ->

	describe '#create', ->
		it 'saves newsletter', (done) ->
			req =
				body: mock.newsletter
			res =
				send: ->
					spy.should.have.been.calledOnce
					spy.should.have.been.calledWith 201
					Newsletter.find().exec (err, newsletters) ->
						should.not.exist err
						should.exist newsletters
						newsletters.length.should.equal 1
						spy.args[o][1].should.exist
						do done
			spy = sinon.spy res, 'send'
			NewsletterController.create req, res


	describe '#read', ->
		it 'gets all newsletters with populated articles', (done) ->
			@timeout 5000 # Andrew Volchenko works on calculator
			length = 4
			mock.newsletters length, (newsletters) ->
				req = {}
				res =
					send: ->
						spy.should.have.been.calledOnce
						spy.should.have.been.calledWith 200
						Newsletter.find().exec (err, newsletters) ->
							should.not.exist err
							spy.args[o][1].length.should.equal newsletters.length
							for newsletter in spy.args[o][1]
								for article in newsletter.articles
										article.should.be.object
							do done
				spy = sinon.spy res, 'send'
				NewsletterController.read req, res

		it 'sends 404 if newsletters collection is empty', (done) ->
			req = {}
			res =
				send: ->
					spy.should.have.been.calledOnce
					spy.should.have.been.calledWith 404
					do done
			spy = sinon.spy res, 'send'
			NewsletterController.read req, res

	describe '#get_by_id', ->
		it 'gets newsletter by id', (done) ->
			mock.newsletters 5, (newsletters) ->
				id = newsletters[2]._id
				req =
					params:
						id: id
				res =
					send: ->
						spy.should.have.been.calledOnce
						spy.should.have.been.calledWith 200
						Newsletter.findById id, (err, newsletter) ->
							spy.args[o][1].should.exist
							do done
				spy = sinon.spy res, 'send'
				NewsletterController.get_by_id req, res

		it 'sends 404 if newsletter is not found', (done) ->
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
			NewsletterController.get_by_id req, res

	describe '#update', ->

		it 'updates newsletter', (done) ->
			mock.newsletters 5, (newsletters) ->
				updated_newsletter = mock.updated_newsletter
				req =
					params:
						id: newsletters[2]._id
					body: updated_newsletter
				res =
					send: ->
						spy.should.have.been.calledOnce
						spy.should.have.been.calledWith 200
						Newsletter.findById req.params.id, (err, newsletter) ->
							newsletter.articles[o].toString().should.equal updated_newsletter.articles[o].toString();
							do done
				spy = sinon.spy res, 'send'
				NewsletterController.update req, res

		it 'sends 404 if newsletter to update is not found', (done) ->
			updated_newsletter = mock.updated_newsletter
			id = new mock.ObjectId
			req =
				params:
					id: id
				body: updated_newsletter
			res =
				send: ->
					spy.should.have.been.calledOnce
					spy.should.have.been.calledWith 404
					do done
			spy = sinon.spy res, 'send'
			NewsletterController.update req, res

		it 'sends 500 if mongo sucks', (done) ->
			stub = sinon.stub Newsletter, 'findById', (id, callback) ->
				error = new Error
				callback error
			req =
				params:
					id: new mock.ObjectId
			res =
				send: ->
					spy.should.have.been.calledOnce
					spy.should.have.been.calledWith 500
					do done
			spy = sinon.spy res, 'send'
			NewsletterController.update req, res
			do stub.restore

	describe '#delete', ->
		it 'deletes item', (done) ->
			mock.newsletters 10, (newsletters) ->
				id = newsletters[2]._id
				req =
					params:
						id: id
				res =
					send: ->
						spy.should.have.been.calledOnce
						spy.should.have.been.calledWith 200
						Newsletter.findById id, (err, newsletter) ->
							should.not.exist newsletter
						do done
				spy = sinon.spy res, 'send'
				NewsletterController.delete req, res

		it 'sends 404 if newsletter to delete is not found', (done) ->
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
			NewsletterController.delete req, res

	describe '#parse', ->
		it 'saves newsletter articles and replace articles with id', (done) ->

			clone = (obj) ->
				if not obj? or typeof obj isnt 'object'
					return obj
				newInstance = new obj.constructor()
				for key of obj
					newInstance[key] = clone obj[key]
				return newInstance

			newsletter = mock.newsletter
			mock_article = mock.newsletter_article
			for i in [0..newsletter.articles.length]
				newsletter.articles[i] = mock_article
			req =
				body: clone newsletter
			res = {}
			next = ->
				req.body.should.not.deep.equal newsletter
				do done
			NewsletterController.parse req, res, next
