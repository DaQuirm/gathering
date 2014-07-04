{Slot,Event} = EventsProto.models

class EventViewModel extends Event

	constructor: (options) ->
		super options

		@slot_draft = new nx.Cell value:null

	show_slot_form: ->
		@slot_draft.value = new Slot

	hide_slot_form: ->
		@slot_draft.value = null

	save_slot: (slot) ->
		@slot_draft.value = new Slot
		@slots.append slot


EventsProto.viewmodels.EventViewModel = EventViewModel

