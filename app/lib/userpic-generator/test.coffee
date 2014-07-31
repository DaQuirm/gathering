express = require 'express'
Chance = require 'chance'
userpic = require './index.coffee'
app = do express


app.get '/', (req, res) ->
	{id, colors, w, h, cols, rows, hue_step, ease} = req.query
	id ?= new Chance().natural()
	[id, colors, w, h, cols, rows, hue_step] = ((if arg isnt undefined then parseInt arg else arg) for arg in [id, colors, w, h, cols, rows, hue_step])

	console.log """

		User id: #{id}
		Colors amount: #{colors}
		Width: #{w}
		Height: #{h}
		Colums: #{cols}
		Rows: #{rows}
		Hue step: #{hue_step}
		Ease function: #{ease}"
	"""
	canvas = userpic id, colors, w, h, cols, rows, hue_step, ease

	res.send "<img style=\"border-radius: 100%\" src=\"#{do canvas.toDataURL}\" />"


server = app.listen 3000, ->
	console.log 'Listening on port %d', server.address().port
