Event = EventsProto.models.Event

class EventViewModel extends Event

	constructor: (options) ->
		super options

		@expanded = new nx.Property value:no

EventsProto.viewmodels.EventViewModel = EventViewModel

