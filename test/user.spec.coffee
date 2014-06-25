sinon = require 'sinon'
sinon_chai = require 'sinon-chai'
chai = require 'chai'

should = do chai.should
chai.use sinon_chai

Users = require '../app/controllers/user.coffee'
User = require '../app/models/user.coffee'

mock = require './mock.coffee'

do require './db.coffee'


describe 'User', ->
	describe '#create', ->
		it 'creates new user', (done) ->
			req =
				body: mock.user
			res =
				send: ->
					spy.should.have.been.calledOnce
					spy.should.have.been.calledWith 200
					User.find().exec (err, user)->
						should.exist user
						do done
			spy = sinon.spy res, 'send'
			Users.create req, res

		it 'sends 500 if user to save is invalid', (done) ->
			req =
				body: mock.invalid_user
			res =
				send: ->
					spy.should.have.been.calledOnce
					spy.should.have.been.calledWith 500
					User.find().exec (err, user)->
						user.length.should.equal 0
						do done
			spy = sinon.spy res, 'send'
			Users.create req, res

	describe '#read', ->
		it 'gets all users', (done) ->
			mock.users 5, (users) ->
				req = {}
				res =
					send: ->
						spy.should.have.been.calledOnce
						spy.should.have.been.calledWith 200
						spy.args[0][1].length.should.equal 5
						do done
				spy = sinon.spy res, 'send'
				Users.read req, res

		it 'sends 404 if no users found', (done) ->
			req = {}
			res =
				send: ->
					spy.should.have.been.calledOnce
					spy.should.have.been.calledWith 404
					do done
			spy = sinon.spy res, 'send'
			Users.read req, res
