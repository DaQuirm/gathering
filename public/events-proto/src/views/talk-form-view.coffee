EventsProto.views.TalkFormView = (slot) ->

	nxt.Element 'div',
		nxt.Element 'p'
			nxt.Element 'label',
				nxt.Text 'Topic',
			nxt.Input cell:slot.topic

		nxt.Element 'p',
			nxt.Element 'label',
				nxt.Text 'Duration',
			nxt.Element 'input',
				nxt.Attr 'type', 'number'
				nxt.Input cell: slot.duration, content: [nxt.Attr 'type', 'number']
