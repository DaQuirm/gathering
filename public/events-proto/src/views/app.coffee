EventFormView = EventsProto.views.EventFormView

EventsProto.views.AppView = (app) ->

	nxt.Element 'div',
		nxt.Binding app.events.new_item (new_item) ->
			if not new_item
				nxt.Element 'button',
					nxt.Text '+ Create'
			else
				EventFormView app.events.new_item

	nxt.Element 'ul',
		nxt.Collection app.events.items, ((event) ->
			nxt.Element 'li',
				nxt.Element 'div',
					nxt.Text event.title.value
				nxt.Element 'div',
					nxt.Text "#{(new Date event.start_date.value).getDay()}"
				nxt.Element 'ul',
					nxt.Binding event.expanded, (expanded) ->
						nxt.Class 'expanded', expanded
					nxt.Collection event.talks, (talk) ->
						nxt.Element 'li',
							nxt.Text talk.theme
			),
			nxt.DelegatedEvent 'click',
				'li': (ev, item) ->
					app.events.expand item
