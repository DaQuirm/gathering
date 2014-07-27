sinon = require 'sinon'
sinon_chai = require 'sinon-chai'
chai = require 'chai'

should = do chai.should
chai.use sinon_chai

BaseCRUD = require '../../app/lib/crud.coffee'
Talk = require '../../app/models/talk.coffee'

CRUDCtrl = new BaseCRUD Talk

mock = require '../mock.coffee'

do require '../db.coffee'

describe 'CRUD', ->
	describe '#create', ->

		it 'returns promise and resolve it with created document', (done) ->

			talk = mock.talk

			success = (content) ->
				content.should.exist
				do done

			failure = ->

			CRUDCtrl.create talk
				.then success, failure

		it '''returns promise and reject
					it with err if document to create is invalid''', (done) ->

			talk = mock.invalid_talk

			success = ->

			failure = (err) ->
				err.should.exist
				do done

			CRUDCtrl.create talk
				.then success, failure
