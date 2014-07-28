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
