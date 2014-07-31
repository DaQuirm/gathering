Canvas = require 'canvas'
tinycolor = require 'tinycolor2'
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


paral = (ctx, x, y, w, h, color) ->
	x -= w/4
	y -= h/4
	ctx.lineWidth = 1
	ctx.fillStyle = ctx.strokeStyle = color
	do ctx.beginPath
	ctx.moveTo x + w, y
	ctx.lineTo x + w*3/2, y + h/2
	ctx.lineTo x + w/2, y + h*3/2
	ctx.lineTo x, y + h
	do ctx.closePath
	do ctx.fill
	do ctx.stroke
	# ctx.strokeStyle = 'black'
	# ctx.strokeRect x, y, w, h


fillRandom = (ctx, seed, colors_number, cols, rows, hue_step, easing) ->

	cell_w = ctx.canvas.width / cols
	cell_h = ctx.canvas.height / rows

	cols += 2 # add horizontal borders
	rows += 2 # add vertical borders


	uniqGen = new Chance seed

	steps = Math.ceil rows*cols/2

	ctx.clearRect 0, 0, ctx.canvas.width, ctx.canvas.height


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

		gen_color = tinycolor
			h: (hue_step * color_num + deg) % 360
			s: easeFunctions[easing] color_num, 20, 60, colors_number - 1
			l: easeFunctions[easing] color_num, 20, 65, colors_number - 1

		table[x][y] = table[cols-x-1][rows-y-1] = do gen_color.toHexString

	for x in [0...cols]
		for y in [0...rows]
			color = table[x][y]
			# console.log color
			paral ctx, (x-1)*cell_w, (y-1)*cell_h, cell_w, cell_h, color



createUserpic = (seed, colors_number = 3, w = 100, h = w, cols = 10, rows = cols/2|0, hue_step = 120, easing = 'linear') ->
	console.time 'Userpic generation'
	canvas = new Canvas w, h
	canvas.width = w
	canvas.height = h
	ctx = canvas.getContext '2d'
	fillRandom ctx, seed, colors_number, cols, rows, hue_step, easing
	console.timeEnd 'Userpic generation'
	return canvas

module.exports = createUserpic
