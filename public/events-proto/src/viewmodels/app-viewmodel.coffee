{Event, EventCollection} = EventsProto.models
{EventViewModel}         = EventsProto.viewmodels

class AppViewModel

	constructor: ->
		# @events = new EventCollection
		# do @events.retrieve

		# @new_event = new nx.Cell value:null
		@event_form_visible = new nx.Cell value:no
		@event_draft = new EventViewModel

	render: (node) ->
		node.appendChild (EventsProto.views.AppView @).node

	show_event_form: ->
		@event_form_visible.value = true

EventsProto.viewmodels.AppViewModel = AppViewModel
