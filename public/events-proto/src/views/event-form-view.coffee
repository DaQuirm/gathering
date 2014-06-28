SlotFormView = EventsProto.views.SlotFormView

EventsProto.views.EventFormView = (event) ->
	nxt.Element 'div',
		nxt.Element 'label',
			nxt.Text 'Name'
		nxt.Input cell:event.title
		nxt.Element 'label',
			nxt.Text 'Name'
		nxt.Input cell:event.venue
		nxt.Element 'label',
			nxt.Text 'Name'
		nxt.Input cell:event.start_date

		nxt.Element 'ul',
			nxt.Collection event.slots, (slot) ->
				nxt.Element 'li',
					switch slot.type
						when 'talk'
							TalkView slot.content
						when 'break'
							nxt.Element 'span',
								nxt.Text 'break'
							nxt.Element 'span',
								nxt.Text slot.duration.value

		nxt.Element 'div',
			nxt.Binding event.slots.new_item, (new_item) ->
				if not new_item
					nxt.Element 'button',
						nxt.Text '+ Add talk'
				else
					SlotFormView event.slots.new_item

		nxt.Element 'button',
			nxt.Text 'Add'
