mongoose = require 'mongoose'

mongoose.connect 'mongodb://localhost/test'
connection = mongoose.connection

before (done) ->
	connection.on 'open', ->
		connection.db.dropDatabase done

after (done) ->
	connection.close done

module.exports = ->
	afterEach (done) ->
		connection.db.dropDatabase done
