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
			nxt.Binding app.event_draft, (event_draft) ->
				if event_draft
					EventFormView app
				else
					nxt.Element 'button',
						(
							nxt.Event 'click', ->
								do app.show_event_form
						),
						nxt.Text 'Create Event'
