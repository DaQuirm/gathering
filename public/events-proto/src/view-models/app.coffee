Event            = EventsProto.models.Event
EventsCollection = EventsProto.models.EventsCollection

class AppViewModel

	constructor: ->
		@events = new EventsCollection
		do @events.retrieve

	render: (node) ->
		node.appendChild (EventsProto.views.AppView @).node

EventsProto.viewmodels.AppViewModel = AppViewModel
