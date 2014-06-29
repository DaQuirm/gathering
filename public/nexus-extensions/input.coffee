nxt.Input = ({cell, content, converter, back_converter}) ->
	content or= []

	link = new nx.Cell

	input = nxt.Element 'input',
		nxt.Event 'input', (evt) ->
			link.value = input.node.value
		content...

	link.bind cell, '<->', converter, back_converter
	link.onsync.add (value) ->
		input.node.value = value

	input
