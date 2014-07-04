Slot = EventsProto.models.Slot
{BreakFormView, TalkFormView} = EventsProto.views

EventsProto.views.SlotFormView = (event) ->
	draft = event.slot_draft.value
	nxt.Element 'div',
		nxt.Element 'div',
			nxt.Element 'label',
				nxt.Text 'type'
			nxt.Element 'select',
				(for type, value of Slot.types
					nxt.Element 'option',
						nxt.Text value
						nxt.Attr 'value', value
				)...
				nxt.Event 'input', (ev) ->
					draft.type.value = @value
			nxt.Binding draft.type, (type) ->
				switch type
					when Slot.types.BREAK
						BreakFormView draft
					when Slot.types.TALK
						TalkFormView draft
		nxt.Element 'button',
			nxt.Text 'save slot'
			nxt.Event 'click', (ev) ->
				event.save_slot draft
				do event.hide_slot_form
