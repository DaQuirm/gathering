Slot = EventsProto.models.Slot
BreakForm = EventsProto.views.BreakForm
TalkForm = EventsProto.views.TalkForm

EventsProto.views.SlotFormView = (event) ->
	draft = event.slot_draft
	nxt.Element 'div',
		nxt.Element 'div',
			nxt.Element 'label',
				nxt.Text 'type'
			nxt.Element 'select',
				nxt.Collection Slot.types, (type) ->
					nxt.Element 'option',
						nxt.Text type
						nxt.Attr 'value', type
				nxt.Event 'input', (ev) ->
					draft.type.value = this.value
			nxt.Binding draft.type, (type) ->
				switch type
					when 'break'
						draft.set_type 'break'
						BreakForm draft.content
					when 'talk'
						draft.set_type 'talk'
						TalkForm draft.content
		nxt.Element 'button',
			nxt.Text 'save slot'
			nxt.Event 'click', (ev) ->
				event.save_slot draft
				do event.hide_slot_form
