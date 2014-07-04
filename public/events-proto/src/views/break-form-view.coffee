EventsProto.views.BreakFormView = (slot) ->

	nxt.Element 'p',
			nxt.Element 'label',
				nxt.Text 'Duration',
			nxt.Element 'input',
				nxt.Attr 'type', 'number'
				nxt.Event 'input', (ev) ->
					slot.duration.value = @value
