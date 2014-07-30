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

	describe '#parse', ->
		it 'saves event talks and replace talks with id', (done) ->

			clone = (obj) ->
				if not obj? or typeof obj isnt 'object'
					return obj
				newInstance = new obj.constructor()
				for key of obj
					newInstance[key] = clone obj[key]
				return newInstance

			event = mock.event
			talk = mock.talk
			for slot in event.slots
				if slot.type is 'talk'
					slot.content = talk
			req =
				body: clone event
			res = {}
			next = ->
				req.body.should.not.deep.equal event
				do done
			Events.parse req, res, next
