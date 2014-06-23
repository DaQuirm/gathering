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
