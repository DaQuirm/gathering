sinon = require 'sinon'
sinon_chai = require 'sinon-chai'
chai = require 'chai'

should = do chai.should
chai.use(sinon_chai)

Talks = require '../app/controllers/talk.coffee'
Talk = require ('../app/models/talk.coffee')

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
					Talk.find().exec (err, t) ->
						should.not.exist err;
						should.exist t;
						do done
			spy = sinon.spy res, 'send'
			Talks.create req, res

		it 'sends 500 in response if talk to save is invalid', (done) ->
			talk = mock.crap.talk
			req =
				body: talk
			res =
				send: ->
					spy.should.have.been.calledOnce
					spy.should.have.been.calledWith 500
					Talk.find().exec (err, t) ->
						should.not.exist err;
						t.length.should.equal 0
						do done
			spy = sinon.spy res, 'send'
			Talks.create req, res


	describe '#read', ->
		it 'gets all news', (done) ->
			length = 10
			mock.talks length, () ->
				req = {}
				res =
					send: ->
						spy.should.have.been.calledOnce
						spy.should.have.been.calledWith 200
						Talk.find().exec (err, d) ->
							should.not.exist err;
							d.length.should.equal length
							spy.args[0][1].length.should.equal d.length
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

	describe '#getById', ->
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
							spy.args[0][1][2].should.equal talk
							do done
			spy = sinon.spy res, 'send'
			Talks.getById req, res

		it 'sends 404 if talk not found', (done) ->
			id = new mock.ObjectID
			req =
				params:
					id: id
			res =
				send: ->
					spy.should.have.been.calledOnce
					spy.should.have.been.calledWith 404
					do done
			spy = sinon.spy res, 'send'
			Talks.getById req, res

	describe '#update', ->
		it 'updates item', (done) ->
			mock.talks 10, (talks) ->
				id = talks[2]._id
				req =
					params:
						id: id
					body: mock.updatedTalk
				res =
					send: ->
						spy.should.have.been.calledOnce
						spy.should.have.been.calledWith 200
						Talk.findById id, (err, talk) ->
							spy.args[0][1][2].__v.should.equal 1
							do done
				spy = sinon.spy res, 'send'
				Talks.update req, res

		it 'sends 404 if talk to update not found', (done) ->
			id = new mock.ObjectID
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
							should.not.exist err
							do done
				spy = sinon.spy res, 'send'
				Talks.delete req, res
