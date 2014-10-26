sinon = require 'sinon'
sinon_chai = require 'sinon-chai'
chai = require 'chai'
bcrypt = require 'bcrypt'

should = do chai.should
chai.use sinon_chai

LocalAccount = require '../service/models/local-account.coffee'

mock = require './mock.coffee'

do require './db.coffee'

describe 'LocalAccount', ->

	local_account_data = null

	beforeEach ->
		local_account_data =
			email: 'email@email.com'
			password: 'password'
			user: new mock.ObjectId

	describe 'match_password', ->

		it 'matches password with hash', (done) ->
			salt = do bcrypt.genSaltSync
			{password} = local_account_data
			bcrypt.hash password, 8, (err, hash) ->
				local_account_data.password = hash
				account = new LocalAccount local_account_data
				account.match_password password, (err, match) ->
					match.should.equal yes
					do done

	describe 'pre save', ->

		it 'hashes password before save', (done) ->

			LocalAccount.create local_account_data, (err, account) ->
				account.match_password local_account_data.password, (err, match) ->
					match.should.equal yes
					do done
