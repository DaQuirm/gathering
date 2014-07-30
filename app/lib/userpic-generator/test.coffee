express = require 'express'
userpic = require './index.coffee'
app = do express


app.get '/', (req, res) ->
	{id, colors, w, h, cols, rows}  = req.query
	console.log req.query
	console.log "get userpic for #{id ? 'random'} user in #{colors ? 3} colors"
	res.send "<img src=\"#{do userpic(id, colors, w, h, cols, rows).toDataURL}\" />"


server = app.listen 3000, ->
	console.log 'Listening on port %d', server.address().port
