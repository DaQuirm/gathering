{Event, EventCollection} = EventsProto.models
{EventViewModel}         = EventsProto.viewmodels

class AppViewModel

	constructor: ->
		@events = new EventCollection
		do @events.retrieve

		@event_draft = new nx.Cell value:null

	render: (node) ->
		node.appendChild (EventsProto.views.AppView @).node

	show_event_form: ->
		@event_draft.value = new EventViewModel

	hide_event_form: ->
		@event_draft.value = null

	save_event: (event) ->
		@event_draft.value = new EventViewModel
		@events.create event, (event) =>
			@events.items.append event

EventsProto.viewmodels.AppViewModel = AppViewModel
