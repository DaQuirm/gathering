Event = EventsProto.models.Event

class EventViewModel extends Event

	constructor: (options) ->
		super options

		@expanded = new nx.Cell value:no

EventsProto.viewmodels.EventViewModel = EventViewModel

