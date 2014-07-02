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

		nxt.Collection draft.slots, (slot) ->
			switch slot.type.value
				when 'break'
					nxt.Element 'div',
						nxt.Element 'span',
							nxt.Text 'Break for '
						nxt.Element 'span',
							nxt.Text slot.content.duration.value
				when 'talk'
					nxt.Element 'div',
						nxt.Element 'span',
							nxt.Text 'topic'
						nxt.Element 'span',
							nxt.Text slot.content.topic.value

		nxt.Binding draft.slot_form_visible, (visible) ->
			if visible
				SlotFormView draft
			else
				nxt.Element 'button',
						(
							nxt.Event 'click', draft.show_slot_form.bind draft
						),
						nxt.Text 'Create Slot' 
