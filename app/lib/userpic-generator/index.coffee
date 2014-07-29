Canvas = require 'canvas'

rand = (is_integer, from, to) ->
	random = do Math.random
	is_integer = if is_integer is undefined then false else is_integer;
	from = if from is undefined then 0 else from;
	to = if to is undefined then 1 else to;

	if is_integer
		from = Math.ceil from
		to = Math.ceil to
		random = Math.floor(random * (to - from + 1)) + from
	else
		random = random * (to - from) + from

	return random


paral = (x, y, w, h, color) ->
	x -= w/4
	y -= h/4
	@lineWidth = 1
	@fillStyle = @strokeStyle = color
	do @beginPath
	@moveTo x + w, y
	@lineTo x + w*3/2, y + h/2
	@lineTo x + w/2, y + h*3/2
	@lineTo x, y + h
	do @closePath
	do @fill
	do @stroke
	#@strokeStyle = 'black'
	#@strokeRect x, y, w, h


fillRandom = ->
	cell_w = 10
	cell_h = 20
	rows = 2 + Math.floor @canvas.height / cell_h
	cols = 2 + Math.floor @canvas.width / cell_w

	colors = 3

	steps = Math.ceil rows*cols/2

	@clearRect 0, 0, @canvas.width, @canvas.height


	table = ([] for i in [0...cols])


	deg = rand yes, 0, 359
	for i in [0...steps]
		x = i % cols
		y = Math.floor i/cols
		colorNumber = rand yes, 0, colors - 1
		table[x][y] = table[cols-x-1][rows-y-1] = "hsl(#{(120*colorNumber+deg)%360}, #{Math.floor(17+colorNumber*100/colors)}%, #{Math.floor(20+colorNumber*100/colors)}%)"

	for x in [0...cols]
		for y in [0...rows]
			color = table[x][y]
			console.log color
			paral.call @, (x-1)*cell_w, (y-1)*cell_h, cell_w, cell_h, color



createUserpic = ->
	canvas = new Canvas 100, 100
	ctx = canvas.getContext '2d'
	fillRandom.call ctx
	return canvas

module.exports = createUserpic
