sinon = require 'sinon'
sinon_chai = require 'sinon-chai'
chai = require 'chai'

should = do chai.should
chai.use sinon_chai

Events = require '../app/controllers/event.coffee'
Event = require '../app/models/event.coffee'

mock = require './mock.coffee'

do require './db.coffee'


describe 'Event', ->

	describe '#create', ->
		it 'saves valid event', (done) ->
			req =
				body: mock.event
			res =
				send: ->
					spy.should.have.been.calledOnce
					spy.should.have.been.calledWith 200
					Event.find().exec (err, events) ->
						should.not.exist err
						should.exist events
						do done
			spy = sinon.spy res, 'send'
			Events.create req, res

		it 'sends 500 if event slot has invalid type', (done) ->
			req =
				body: mock.event_with_invalid_slot_type
			res =
				send: ->
					spy.should.have.been.calledOnce
					spy.should.have.been.calledWith 500
					Event.find().exec (err, events) ->
						should.not.exist err
						events.length.should.equal 0
						do done
			spy = sinon.spy res, 'send'
			Events.create req, res

		it 'sends 500 if event slot has invalid content', (done) ->
			req =
				body: mock.event_with_invalid_slot_content
			res =
				send: ->
					spy.should.have.been.calledOnce
					spy.should.have.been.calledWith 500
					Event.find().exec (err, events) ->
						should.not.exist err
						events.length.should.equal 0
						do done
			spy = sinon.spy res, 'send'
			Events.create req, res

	describe '#read', ->
		it 'gets all events with populated talks', (done) ->
			length = 4
			mock.events length, (events) ->
				req = {}
				res =
					send: ->
						spy.should.have.been.calledOnce
						spy.should.have.been.calledWith 200
						Event.find().exec (err, events) ->
							should.not.exist err
							events.length.should.equal length
							spy.args[0][1].length.should.equal events.length
							for event in spy.args[0][1]
								for slot in event
									if slot.type is 'talk'
										slot.content.should.be.object
										slot.content.topic.should.exist
							do done
				spy = sinon.spy res, 'send'
				Events.read req, res

		it 'sends 404 if events collection is empty', (done) ->
			req = {}
			res =
				send: ->
					spy.should.have.been.calledOnce
					spy.should.have.been.calledWith 404
					do done
			spy = sinon.spy res, 'send'
			Events.read req, res

	describe '#get_by_id', ->
		it 'gets event by id', (done) ->
			mock.events 5, (events) ->
				id = events[2]._id
				req =
					params:
						id: id
				res =
					send: ->
						spy.should.have.been.calledOnce
						spy.should.have.been.calledWith 200
						Event.findById id, (err, event) ->
							spy.args[0][1].should.exist
							do done
				spy = sinon.spy res, 'send'
				Events.get_by_id req, res

		it 'sends 404 if event is not found', (done) ->
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
			Events.get_by_id req, res

	describe '#update', ->
		check_updated = (expected, got) ->
			i = 0
			got.title.should.equal expected.title
			got.start_date.getTime().should.equal expected.start_date
			got.venue.should.equal expected.venue
			for slot in got.slots
				got.slots[i].type.should.equal slot.type
				if got.slots[i].type is 'break'
					got.slots[i].content.should.equal slot.content
				else
					got.slots[i].content.toString().should.equal slot.content.toString()
				i++

		it 'updates event', (done) ->
			mock.events 5, (events) ->
				updated_event = mock.updated_event
				req =
					params:
						id: events[2]._id
					body: updated_event
				res =
					send: ->
						spy.should.have.been.calledOnce
						spy.should.have.been.calledWith 200
						Event.findById req.params.id, (err, event) ->
							check_updated updated_event, event
							do done
				spy = sinon.spy res, 'send'
				Events.update req, res

		it 'sends 404 if event to update is not found', (done) ->
			updated_event = mock.updated_event
			id = new mock.ObjectId
			req =
				params:
					id: id
				body: updated_event
			res =
				send: ->
					spy.should.have.been.calledOnce
					spy.should.have.been.calledWith 404
					do done
			spy = sinon.spy res, 'send'
			Events.update req, res

		it 'sends 500 if mongo sucks', (done) ->
			stub = sinon.stub Event, 'findById', (id, callback) ->
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
			Events.update req, res
			do stub.restore

	describe '#delete', ->
		it 'deletes item', (done) ->
			mock.events 10, (events) ->
				id = events[2]._id
				req =
					params:
						id: id
				res =
					send: ->
						spy.should.have.been.calledOnce
						spy.should.have.been.calledWith 200
						Event.findById id, (err, event) ->
							should.not.exist event
						do done
				spy = sinon.spy res, 'send'
				Events.delete req, res

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
			Events.delete req, res
