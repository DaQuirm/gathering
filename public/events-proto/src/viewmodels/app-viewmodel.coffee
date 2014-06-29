{Event, EventCollection} = EventsProto.models
{EventViewModel}         = EventsProto.viewmodels

class AppViewModel

	constructor: ->
		@events = new EventCollection
		do @events.retrieve

		@new_event = new nx.Cell value:null

	render: (node) ->
		node.appendChild (EventsProto.views.AppView @).node

	show_create_form: ->
		@new_event.value = new EventViewModel

EventsProto.viewmodels.AppViewModel = AppViewModel
