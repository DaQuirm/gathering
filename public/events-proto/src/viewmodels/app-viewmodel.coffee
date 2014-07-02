{Event, EventCollection} = EventsProto.models
{EventViewModel}         = EventsProto.viewmodels

class AppViewModel

	constructor: ->
		@events = new EventCollection
		do @events.retrieve

		@event_form_visible = new nx.Cell value:no
		@event_draft = new EventViewModel

	render: (node) ->
		node.appendChild (EventsProto.views.AppView @).node

	show_event_form: ->
		@event_form_visible.value = true

	hide_event_form: ->
		@event_form_visible.value = false

	save_event: (event) ->
		@event_draft = new EventViewModel
		@events.items.append event

EventsProto.viewmodels.AppViewModel = AppViewModel
