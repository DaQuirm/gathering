{Slot,Event} = EventsProto.models

class EventViewModel extends Event

	constructor: (options) ->
		super options

		@slot_draft = new Slot
		@slot_form_visible = new nx.Cell value:no

	show_slot_form: ->
		@slot_form_visible.value = yes

	save_slot: (slot) ->
		@slots.append slot


EventsProto.viewmodels.EventViewModel = EventViewModel

