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

	describe '#get_by_id', ->
		it 'gets user by id', (done) ->
			mock.users 5, (users) ->
				req = 
					params: 
						id: users[2]._id
				res =
					send: ->
						spy.should.have.been.calledOnce
						spy.should.have.been.calledWith 200
						spy.args[0][1]._id.toString().should.equal users[2]._id.toString()
						spy.args[0][1].first_name.should.equal users[2].first_name
						spy.args[0][1].last_name.should.equal users[2].last_name
						spy.args[0][1].email.should.equal users[2].email
						do done
				spy = sinon.spy res, 'send'
				Users.get_by_id req, res

		it 'sends 404 if no users found', (done) ->
			req =
				params:
					id: new mock.ObjectId
			res =
				send: ->
					spy.should.have.been.calledOnce
					spy.should.have.been.calledWith 404
					do done
			spy = sinon.spy res, 'send'
			Users.get_by_id req, res

	describe '#update', ->
		it 'updates user', (done) ->
			mock.users 5, (users) ->
				req =
					params: 
						id: users[2]._id
					body: mock.updated_user
				res =
					send: ->
						spy.should.have.been.calledOnce
						spy.should.have.been.calledWith 200
						User.findById req.params.id, (err, found) ->
							found.first_name.should.equal mock.updated_user.first_name
							found.last_name.should.equal mock.updated_user.last_name
							found.email.should.equal mock.updated_user.email
							do done
				spy = sinon.spy res, 'send'
				Users.update req, res

		it 'sends 404 if user to update is not found', (done) ->
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
			Users.update req, res

	describe '#delete', ->
		it 'deletes user by id', (done) ->
			mock.users 5, (users) ->
				req =
					params: 
						id: users[2]._id
				res =
					send: ->
						spy.should.have.been.calledOnce
						spy.should.have.been.calledWith 200
						User.find().exec (err, found) ->
							found.length.should.equal 4
							do done
				spy = sinon.spy res, 'send'
				Users.delete req, res

		it 'sends 404 if user to delete is not found', (done) ->
			req =
				params: 
					id: new mock.ObjectId
			res =
				send: ->
					spy.should.have.been.calledOnce
					spy.should.have.been.calledWith 404
					do done
			spy = sinon.spy res, 'send'
			Users.delete req, res
