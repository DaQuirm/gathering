{Talk,Event} = EventsProto.models

class EventViewModel extends Event

	constructor: (options) ->
		super options

		@slot_draft = new nx.Cell value:null

	show_slot_form: ->
		@slot_draft.value = new Talk

	hide_slot_form: ->
		@slot_draft.value = null

	save_slot: (slot) ->
		@slots.append slot
		@slot_draft.value = new Talk


EventsProto.viewmodels.EventViewModel = EventViewModel

