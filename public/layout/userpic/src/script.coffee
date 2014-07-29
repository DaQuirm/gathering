rand = (is_integer, from, to, seed) ->
	random = seed || do Math.random
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



fillRandom = (seed) ->
	ctx = this.getContext '2d'

	uniqGen = new Chance seed

	#console.log do uniqGen.random

	cell_w = 10
	cell_h = 20
	rows = 2 + Math.floor this.height / cell_h
	cols = 2 + Math.floor this.width / cell_w

	colors = 3

	steps = Math.ceil rows*cols/2 #25

	ctx.clearRect 0, 0, this.width, this.height


	table = ([] for i in [0...cols])


	deg = rand yes, 0, 359, do uniqGen.random

	for i in [0...steps]
		x = i % cols
		y = Math.floor i/cols
		colorNumber = rand yes, 0, colors - 1, do uniqGen.random
		table[x][y] = table[cols-x-1][rows-y-1] = "hsl(#{(120*colorNumber+deg)%360}, #{17+colorNumber*100/colors}%, #{20+colorNumber*100/colors}%)"

	for x in [0...cols]
		for y in [0...rows]
			color = table[x][y]
			paral.call ctx, (x-1)*cell_w, (y-1)*cell_h, cell_w, cell_h, color


idid = 0

createUserpic = ->
	canvas = document.createElement 'canvas'
	div = document.createElement 'div'
	inner = document.createElement 'div'
	canvas.width = 100
	canvas.height = 100
	ctx = canvas.getContext '2d'

	mockFill = ->
		# id = do Date.now
		id = idid++
		# id = rand yes, 0, 100
		fillRandom.call canvas, id
		inner.innerHTML = id

	do mockFill

	# canvas.addEventListener 'mouseover', ->
	# 	do mockFill

	div.appendChild canvas
	div.appendChild inner
	document.body.appendChild div

window.onload = ->
	start = do Date.now
	do createUserpic for i in [0...100]
	time = do Date.now - start
	console.log time, time / 100