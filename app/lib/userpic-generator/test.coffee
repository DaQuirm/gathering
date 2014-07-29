express = require 'express'
userpic = require './index.coffee'
app = do express

userpic().toDataURL (err, str) ->
	console.log str

app.get '/', (req, res) ->
	res.send '<img src="' + userpic().toDataURL() + '" />'

server = app.listen 3000, ->
	console.log 'Listening on port %d', server.address().port
