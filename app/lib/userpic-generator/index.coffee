Canvas = require 'canvas'
tiny_color = require 'tinycolor2'
Chance = require 'chance'

easeFunctions =
	linear: (t, b, c, d) ->
		return c*t/d + b;

	easeOutQuart: (t, b, c, d) ->
		t /= d
		t--
		return -c * (t*t*t*t - 1) + b

	easeInQuart: (t, b, c, d) ->
		t /= d
		return c*t*t*t*t + b


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


fillRandom = (seed, colors_number, cols, rows, easing) ->

	cell_w = @canvas.width / cols
	cell_h = @canvas.height / rows

	cols += 2 # add horizontal borders
	rows += 2 # add vertical borders


	uniqGen = new Chance seed

	steps = Math.ceil rows*cols/2

	@clearRect 0, 0, @canvas.width, @canvas.height


	table = ([] for i in [0...cols])


	deg = uniqGen.natural
		min: 0
		max: 359




	for i in [0...steps]
		x = i % cols
		y = Math.floor i/cols
		color_num = if colors_number is 1 then 1 else uniqGen.natural
			min: 0
			max: colors_number - 1

		gen_color = tiny_color
			h: (120*color_num+deg)%360
			s: easeFunctions[easing] color_num, 20, 60, colors_number - 1
			l: easeFunctions[easing] color_num, 20, 60, colors_number - 1

		table[x][y] = table[cols-x-1][rows-y-1] = do gen_color.toHexString

	for x in [0...cols]
		for y in [0...rows]
			color = table[x][y]
			# console.log color
			paral.call @, (x-1)*cell_w, (y-1)*cell_h, cell_w, cell_h, color



createUserpic = (seed, colors_number = 3, w = 100, h = w, cols = 10, rows = cols/2|0, easing = 'linear') ->
	canvas = new Canvas w, h
	ctx = canvas.getContext '2d'
	fillRandom.call ctx, seed, colors_number, cols, rows, easing
	return canvas

module.exports = createUserpic
