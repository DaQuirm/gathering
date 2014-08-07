nxt.Input = ({cell, content, converter, back_converter}) ->
	content or= []

	input = nxt.Element 'input',
		content...,
		nxt.Event 'input', (evt) ->
			cell.value =
				if back_converter?
					back_converter input.data.node.value
				else
					input.data.node.value

	cell.onvalue.add (value) ->
		input.data.node.value =
			if converter?
				converter value
			else
				value

	input
