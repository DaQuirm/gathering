EventFormView = EventsProto.views.EventFormView

EventsProto.views.AppView = (app) ->

	nxt.Element 'main',
		nxt.Element 'div',
			nxt.Binding app.event_form_visible, (visible) ->
				if visible
					EventFormView app.event_draft
				else
					nxt.Element 'button',
						(
							nxt.Event 'click', app.show_event_form.bind app
						),
						nxt.Text 'Create Event' 
