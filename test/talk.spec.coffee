sinon = require 'sinon'
sinon_chai = require 'sinon-chai'
chai = require 'chai'

should = do chai.should
chai.use sinon_chai

Talks = require '../app/controllers/talk.coffee'
Talk = require '../app/models/talk.coffee'

mock = require './mock.coffee'

do require './db.coffee'


describe 'Talk', ->

	describe '#create', ->
		it 'saves new talk to talks collection', (done) ->
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
			Talks.create req, res

		it 'sends 500 in response if talk to save is invalid', (done) ->
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
			Talks.create req, res


	describe '#read', ->
		it 'gets all news', (done) ->
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
				Talks.read req, res

		it 'sends 404 if talks collection is empty', (done) ->
			req = {}
			res =
				send: ->
					spy.should.have.been.calledOnce
					spy.should.have.been.calledWith 404
					do done
			spy = sinon.spy res, 'send'
			Talks.read req, res

	describe '#get_by_id', ->
		it 'gets talk by id', (done) ->
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
				Talks.get_by_id req, res

		it 'sends 404 if talk is not found', (done) ->
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
			Talks.get_by_id req, res

	describe '#update', ->
		it 'updates item', (done) ->
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
				Talks.update req, res

		it 'sends 404 if talk to update is not found', (done) ->
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
			Talks.update req, res

	describe '#delete', ->
		it 'deletes item', (done) ->
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
				Talks.delete req, res

		it 'sends 404 if talk to delete is not found', (done) ->
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
			Talks.delete req, res
