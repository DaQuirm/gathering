rand = (is_integer, from, to) ->
	random = do Math.random
	from = if from is undefined then 0 else from;
	to = if to is undefined then 1 else to;

	if is_integer
		from = Math.ceil from
		to = Math.ceil to
		random = Math.floor(random * (to - from + 1)) + from
	else
		random = random * (to - from) + from

	return random


rhombus = (x, y, w, h, color) ->
	x -= w/2
	y -= h/2
	this.lineWidth = 1;
	this.fillStyle = this.strokeStyle = color
	do this.beginPath
	this.moveTo x, y
	this.lineTo x + w / 2, y + h / 2
	this.lineTo x, y + h
	this.lineTo x - w / 2, y + h / 2
	do this.closePath
	do this.fill
	do this.stroke

paral = (x, y, w, h, color) ->
	x -= w/4
	y -= h/4
	this.lineWidth = 1
	this.fillStyle = this.strokeStyle = color
	do this.beginPath
	this.moveTo x + w, y
	this.lineTo x + w*3/2, y + h/2
	this.lineTo x + w/2, y + h*3/2
	this.lineTo x, y + h
	do this.closePath
	do this.fill
	do this.stroke
	#this.strokeStyle = 'black'
	#this.strokeRect x, y, w, h



fillRandom = ->
	ctx = this.getContext '2d'

	cell_w = 10
	cell_h = 20
	rows = 2 + Math.floor this.height / cell_h
	cols = 2 + Math.floor this.width / cell_w

	colors = 3

	steps = Math.ceil rows*cols/2 #25

	ctx.clearRect 0, 0, this.width, this.height


	table = ([] for i in [0...cols])


	deg = rand yes, 0, 359

	for i in [0...steps]
		x = i % cols
		y = Math.floor i/cols
		colorNumber = rand yes, 0, colors - 1
		table[x][y] = table[cols-x-1][rows-y-1] = "hsl(#{(120*colorNumber+deg)%360}, #{17+colorNumber*100/colors}%, #{20+colorNumber*100/colors}%)"

	for x in [0...cols]
		for y in [0...rows]
			color = table[x][y]
			paral.call ctx, (x-1)*cell_w, (y-1)*cell_h, cell_w, cell_h, color




createUserpic = ->
	canvas = document.createElement 'canvas'
	canvas.width = 100
	canvas.height = 100
	ctx = canvas.getContext '2d'
	fillRandom.call canvas

	canvas.addEventListener 'mouseover', fillRandom.bind canvas

	document.body.appendChild canvas

window.onload = ->
	do createUserpic for i in [0...100]
