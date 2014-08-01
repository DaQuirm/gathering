sinon = require 'sinon'
sinon_chai = require 'sinon-chai'
chai = require 'chai'
bcrypt = require 'bcrypt-nodejs'

should = do chai.should
chai.use sinon_chai

LocalAccount = require '../app/models/local-account.coffee'

mock = require './mock.coffee'

do require './db.coffee'

local_account_data =
	email: 'email@email.com'
	password: 'password'
	user: new mock.ObjectId

describe 'LocalAccount', ->

	describe 'match_password', ->

		it 'matches password with hash', (done) ->
			salt = do bcrypt.genSaltSync
			password = local_account_data.password
			bcrypt.hash password, salt, null, (err, hash) ->
				local_account_data.password = hash
				account = new LocalAccount local_account_data
				match = account.match_password password
				match.should.equal yes
				local_account_data.password = 'password'
				do done

	describe 'pre save', ->

		it 'hashes password before save', (done) ->

			LocalAccount.create local_account_data
				.then (account) ->
					match = account.match_password local_account_data.password
					match.should.equal yes
					do done
