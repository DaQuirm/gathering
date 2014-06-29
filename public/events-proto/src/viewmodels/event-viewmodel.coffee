Event = EventsProto.models.Event

class EventViewModel extends Event

	constructor: (options) ->
		super options

		@expanded = new nx.Cell value:no
		@new_slot = new nx.Cell value:null

EventsProto.viewmodels.EventViewModel = EventViewModel

