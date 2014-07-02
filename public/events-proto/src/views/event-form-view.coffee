SlotFormView = EventsProto.views.SlotFormView

EventsProto.views.EventFormView = (draft) ->

	nxt.Element 'div',
		nxt.Element 'p',
			nxt.Element 'label',
				nxt.Text 'Event Title',
			nxt.Input cell:draft.title
		nxt.Element 'p',
			nxt.Element 'label',
				nxt.Text 'Venue',
			nxt.Input cell:draft.venue
		nxt.Element 'p',
			nxt.Element 'label',
				nxt.Text 'Start Date',
			date = nxt.Element 'input',
				(nxt.Attr 'type', 'date'),
				nxt.Event 'change', (ev) ->
					draft.start_date.value = new Date this.value

		nxt.Binding draft.slot_form_visible, (visible) ->
			if visible
				SlotFormView draft.slot_draft
			else
				nxt.Element 'button',
						(
							nxt.Event 'click', draft.show_slot_form.bind draft
						),
						nxt.Text 'Create Slot' 
