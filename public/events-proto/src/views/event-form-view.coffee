{SlotFormView,Slot} = EventsProto.views

EventsProto.views.EventFormView = (app) ->

	draft = app.event_draft.value

	nxt.Element 'div',
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
				Slot slot

			nxt.Binding draft.slot_draft, (slot_draft) ->
				if slot_draft
					SlotFormView draft
				else
					nxt.Element 'button',
							(
								nxt.Event 'click', draft.show_slot_form.bind draft
							),
							nxt.Text 'Create Slot'

		nxt.Element 'div',
			nxt.Element 'button',
				nxt.Text 'Save event'
				nxt.Event 'click', ->
					app.save_event draft
					do app.hide_event_form
