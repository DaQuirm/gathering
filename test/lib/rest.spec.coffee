sinon = require 'sinon'
sinon_chai = require 'sinon-chai'
chai = require 'chai'

should = do chai.should
chai.use sinon_chai

RestCtrl = require '../../app/lib/rest.coffee'
Talk = require '../../app/models/talk.coffee'

rest = new RestCtrl Talk

mock = require '../mock.coffee'

do require '../db.coffee'

describe 'RestCtrl', ->

	describe '#create', ->

		it 'sends [200, created]', (done) ->
			req =
				body: mock.talk
			res =
				send: ->
					spy.should.have.been.calledOnce
					Talk.find().exec()
						.then (found) ->
							found.should.exist
							spy.should.have.been.calledWith 200
							spy.args[0][1].should.exist
							do done

			spy = sinon.spy res, 'send'
			rest.create req, res

		it 'sends 500 if document to create is invalid', (done) ->
			req =
				body: mock.invalid_talk
			res =
				send: ->
					spy.should.have.been.calledOnce
					Talk.find().exec()
						.then (found) ->
							found.length.should.equal 0
							spy.should.have.been.calledWith 500
							do done

			spy = sinon.spy res, 'send'
			rest.create req, res

	describe '#read', ->

		it 'sends [200, collection]', (done) ->

			mock.talks 10, (mocked) ->
				req = {}
				res =
					send: ->
						spy.should.have.been.calledOnce
						Talk.find().exec()
							.then (found) ->
								found.should.exist
								spy.should.have.been.calledWith 200
								spy.args[0][1].length.should.equal mocked.length
								do done

				spy = sinon.spy res, 'send'
				rest.read req, res

		it 'sends 204 if collection is empty', (done) ->
			req = {}
			res =
				send: ->
					spy.should.have.been.calledOnce
					spy.should.have.been.calledWith 204
					do done

			spy = sinon.spy res, 'send'
			rest.read req, res

	describe '#get_by_id', ->
		it 'sends [200, found]', (done) ->
			mock.talks 10, (mocked) ->
				id = mocked[2]._id
				req =
					params:
						id: id
				res =
					send: ->
						spy.should.have.been.calledOnce
						spy.should.have.been.calledWith 200
						spy.args[0][1].should.exist
						do done

				spy = sinon.spy res, 'send'
				rest.get_by_id req, res

		it 'sends 404 if document not found', (done) ->
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
			rest.get_by_id req, res

	describe '#update', ->
		it 'sends [200, updated]', (done) ->
			mock.talks 10, (mocked) ->
				id = mocked._id
				update = mock.updated_talk
				req =
					params:
						id: id
					body: update

				res =
					send: ->
						spy.should.have.been.calledOnce
						spy.should.have.been.calledWith 200
						spy.args[0][1].should.exist
						do done

				spy = sinon.spy res, 'send'
				rest.update req, res

		it 'sends 404 if document to update is not found', (done) ->
			id = new mock.ObjectId
			update = mock.updated_talk
			req =
				params:
					id: id
				body: update

			res =
				send: ->
					spy.should.have.been.calledOnce
					spy.should.have.been.calledWith 404
					do done

			spy = sinon.spy res, 'send'
			rest.update req, res
