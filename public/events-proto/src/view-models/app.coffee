Event           = EventsProto.models.Event
EventCollection = EventsProto.models.EventCollection

class AppViewModel

	constructor: ->
		@events = new EventCollection
		do @events.retrieve

	render: (node) ->
		node.appendChild (EventsProto.views.AppView @).node

EventsProto.viewmodels.AppViewModel = AppViewModel
