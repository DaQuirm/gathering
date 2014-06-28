Slot = EventsProto.models.Slot

EventsProto.views.SlotFormView = (slot) ->

	nxt.Element 'div',
		nxt.Element 'label',
			nxt.Text 'type'
		nxt.Element 'select',
			nxt.Element 'option',
				nxt.Text Slot.types.TALK
			nxt.Element 'option',
				nxt.Text Slot.types.BREAK
			nxt.Event 'onchange', (evt) ->
				slot.type.value = evt.target.value
		nxt.Binding slot.type, (type) ->
			switch type
				when Slot.types.TALK
					nxt.Element 'label',
						nxt.Text 'Topic'
					nxt.Input
						cell:slot.content.topic
					nxt.Element 'label',
						nxt.Text 'Duration'
					nxt.Input
						cell:slot.content
						content: [
							nxt.Attr 'type', 'number'
						]
					nxt.Element 'label',
						nxt.Text 'Authors'
					nxt.Input
						cell:slot.content.authors
						converter: (authors) ->
							do authors.toString
						back_converter: (string) ->
							string.split ','
				when Slot.types.BREAK
					nxt.Element 'label',
						nxt.Text 'Duration'
					nxt.Input
						cell:slot.content
						content: [
							nxt.Attr 'type', 'number'
						]

		nxt.Element 'button',
			nxt.Text 'Add'

