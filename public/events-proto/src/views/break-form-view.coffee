EventsProto.views.BreakForm = (slot_content) ->

	nxt.Element 'p',
			nxt.Element 'label',
				nxt.Text 'Duration',
			nxt.Element 'input',
				nxt.Attr 'type', 'number'
				nxt.Event 'input', (ev) ->
					slot_content.duration.value = this.value
