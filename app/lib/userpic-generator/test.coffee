express = require 'express'
Chance = require 'chance'
userpic = require './index.coffee'
app = do express


app.get '/', (req, res) ->
	{id, colors, w, h, cols, rows, ease} = req.query
	id ?= new Chance().natural()
	[id, colors, w, h, cols, rows] = ((if arg isnt undefined then parseInt arg else arg) for arg in [id, colors, w, h, cols, rows])

	console.log id, colors, w, h, cols, rows, ease

	canvas = userpic id, colors, w, h, cols, rows, ease

	console.log "get userpic for #{id} user in #{colors ? 3} colors"
	res.send "<img style=\"border-radius: 100%\" src=\"#{do canvas.toDataURL}\" />"


server = app.listen 3000, ->
	console.log 'Listening on port %d', server.address().port
