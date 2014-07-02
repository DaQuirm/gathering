EventsProto.views.TalkForm = (slot_content) ->

	nxt.Element 'div',
		nxt.Element 'p'
			nxt.Element 'label',
				nxt.Text 'Topic',
			nxt.Input cell:slot_content.topic

		nxt.Element 'p',
			nxt.Element 'label',
				nxt.Text 'Duration',
			nxt.Element 'input',
				nxt.Attr 'type', 'number'
				nxt.Event 'input', (ev) ->
					slot_content.duration.value = @value
