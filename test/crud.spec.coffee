sinon = require 'sinon'
sinon_chai = require 'sinon-chai'
chai = require 'chai'

should = do chai.should
chai.use sinon_chai

Talk = require '../app/models/talk.coffee'
TalkCRUDController = require('../app/controllers/crud.coffee') Talk

mock = require './mock.coffee'

do require './db.coffee'

describe 'CrudController', ->

	describe '#create', ->
		it 'saves document', (done) ->
			req =
				body: mock.talk
			res =
				send: ->
					spy.should.have.been.calledOnce
					spy.should.have.been.calledWith 200
					Talk.find().exec (err, talks) ->
						should.not.exist err
						should.exist talks
						do done
			spy = sinon.spy res, 'send'
			TalkCRUDController.create req, res

		it 'sends 500 in response if document to save is invalid', (done) ->
			talk = mock.invalid_talk.talk
			req =
				body: talk
			res =
				send: ->
					spy.should.have.been.calledOnce
					spy.should.have.been.calledWith 500
					Talk.find().exec (err, talks) ->
						should.not.exist err
						talks.length.should.equal 0
						do done
			spy = sinon.spy res, 'send'
			TalkCRUDController.create req, res


	describe '#read', ->
		it 'gets the whole collection', (done) ->
			length = 10
			mock.talks length, ->
				req = {}
				res =
					send: ->
						spy.should.have.been.calledOnce
						spy.should.have.been.calledWith 200
						Talk.find().exec (err, talks) ->
							should.not.exist err
							talks.length.should.equal length
							spy.args[0][1].length.should.equal talks.length
							do done
				spy = sinon.spy res, 'send'
				TalkCRUDController.read req, res

		it 'sends 404 if collection is empty', (done) ->
			req = {}
			res =
				send: ->
					spy.should.have.been.calledOnce
					spy.should.have.been.calledWith 404
					do done
			spy = sinon.spy res, 'send'
			TalkCRUDController.read req, res

	describe '#get_by_id', ->
		it 'gets document by id', (done) ->
			mock.talks 10, (talks) ->
				id = talks[2]._id
				req =
					params:
						id: id
				res =
					send: ->
						spy.should.have.been.calledOnce
						spy.should.have.been.calledWith 200
						Talk.findById id, (err, talk) ->
							spy.args[0][1].should.exist
							do done
				spy = sinon.spy res, 'send'
				TalkCRUDController.get_by_id req, res

		it 'sends 404 if document is not found', (done) ->
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
			TalkCRUDController.get_by_id req, res

	describe '#update', ->
		it 'updates document', (done) ->
			check_updated = (expected, got) ->
				expected.topic.should.equal got.topic
				expected.duration.should.equal got.duration
			mock.talks 10, (talks) ->
				id = talks[2]._id
				expected = mock.updated_talk
				req =
					params:
						id: id
					body: mock.updated_talk
				res =
					send: ->
						spy.should.have.been.calledOnce
						spy.should.have.been.calledWith 200
						check_updated expected, spy.args[0][1]
						do done
				spy = sinon.spy res, 'send'
				TalkCRUDController.update req, res

		it 'sends 404 if document to update is not found', (done) ->
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
			TalkCRUDController.update req, res

	describe '#delete', ->
		it 'deletes document', (done) ->
			mock.talks 10, (talks) ->
				id = talks[2]._id
				req =
					params:
						id: id
				res =
					send: ->
						spy.should.have.been.calledOnce
						spy.should.have.been.calledWith 200
						Talk.findById id, (err, talk) ->
							should.not.exist talk
							do done
				spy = sinon.spy res, 'send'
				TalkCRUDController.delete req, res

		it 'sends 404 if document to delete is not found', (done) ->
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
			TalkCRUDController.delete req, res
