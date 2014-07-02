EventFormView = EventsProto.views.EventFormView
EventView = EventsProto.views.Event

EventsProto.views.AppView = (app) ->

	nxt.Element 'main',
		nxt.Element 'div',
			nxt.Class 'events', true
			nxt.Collection app.events.items, (event) ->
				EventView event
		nxt.Element 'div',
			nxt.Class 'create', true
			nxt.Binding app.event_form_visible, (visible) ->
				if visible
					EventFormView app
				else
					nxt.Element 'button',
						(
							nxt.Event 'click', app.show_event_form.bind app
						),
						nxt.Text 'Create Event'
