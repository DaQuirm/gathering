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
				status: -> @
				send: ->
					status_spy.should.have.been.calledOnce
					send_spy.should.have.been.calledOnce
					Talk.find().exec()
						.then (found) ->
							found.should.exist
							status_spy.should.have.been.calledWith 200
							send_spy.args[0][0].should.exist
							do done

			status_spy = sinon.spy res, 'status'
			send_spy = sinon.spy res, 'send'
			rest.create req, res

		it 'sends 500 if document to create is invalid', (done) ->
			req =
				body: mock.invalid_talk
			res =
				status: ->
					status_spy.should.have.been.calledOnce
					Talk.find().exec()
						.then (found) ->
							found.length.should.equal 0
							status_spy.should.have.been.calledWith 500
							do done

			status_spy = sinon.spy res, 'status'
			rest.create req, res

	describe '#read', ->

		it 'sends [200, collection]', (done) ->

			mock.talks 10, (mocked) ->
				req = {}
				res =
					status: -> @
					send: ->
						status_spy.should.have.been.calledOnce
						send_spy.should.have.been.calledOnce
						Talk.find().exec()
							.then (found) ->
								found.should.exist
								status_spy.should.have.been.calledWith 200
								send_spy.args[0][0].length.should.equal mocked.length
								do done

				status_spy = sinon.spy res, 'status'
				send_spy = sinon.spy res, 'send'
				rest.read req, res

		it 'sends 204 if collection is empty', (done) ->
			req = {}
			res =
				status: ->
					status_spy.should.have.been.calledOnce
					status_spy.should.have.been.calledWith 204
					do done

			status_spy = sinon.spy res, 'status'
			rest.read req, res

	describe '#get_by_id', ->
		it 'sends [200, found]', (done) ->
			mock.talks 10, (mocked) ->
				id = mocked[2]._id
				req =
					params:
						id: id
				res =
					status: -> @
					send: ->
						status_spy.should.have.been.calledOnce
						send_spy.should.have.been.calledOnce
						status_spy.should.have.been.calledWith 200
						send_spy.args[0][0].should.exist
						do done

				status_spy = sinon.spy res, 'status'
				send_spy = sinon.spy res, 'send'
				rest.get_by_id req, res

		it 'sends 404 if document not found', (done) ->
			id = new mock.ObjectId
			req =
				params:
					id: id
			res =
				status: ->
					status_spy.should.have.been.calledOnce
					status_spy.should.have.been.calledWith 404
					do done

			status_spy = sinon.spy res, 'status'
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
					status: -> @
					send: ->
						status_spy.should.have.been.calledOnce
						send_spy.should.have.been.calledOnce
						status_spy.should.have.been.calledWith 200
						send_spy.args[0][0].should.exist
						do done

				status_spy = sinon.spy res, 'status'
				send_spy = sinon.spy res, 'send'
				rest.update req, res

		it 'sends 404 if document to update is not found', (done) ->
			id = new mock.ObjectId
			update = mock.updated_talk
			req =
				params:
					id: id
				body: update

			res =
				status: ->
					status_spy.should.have.been.calledOnce
					status_spy.should.have.been.calledWith 404
					do done

			status_spy = sinon.spy res, 'status'
			rest.update req, res

	describe '#delete', ->
		it 'sends [200, deleted]', (done) ->
			mock.talks 10, (mocked) ->
				id = mocked[2]._id
				req =
					params:
						id: id
				res =
					status: -> @
					send: ->
						Talk.findById(id).exec()
							.then (found) ->
								status_spy.should.have.been.calledOnce
								send_spy.should.have.been.calledOnce
								status_spy.should.have.been.calledWith 200
								send_spy.args[0][0].should.exist
								should.not.exist found
								do done

				status_spy = sinon.spy res, 'status'
				send_spy = sinon.spy res, 'send'
				rest.delete req, res

		it 'sends 404 if document to delete not found', (done) ->
			id = new mock.ObjectId
			req =
				params:
					id: id
			res =
				status: ->
					status_spy.should.have.been.calledOnce
					status_spy.should.have.been.calledWith 404
					do done

			status_spy = sinon.spy res, 'status'
			rest.delete req, res

