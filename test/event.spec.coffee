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
