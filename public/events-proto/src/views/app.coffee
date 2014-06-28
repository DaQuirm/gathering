EventsProto.views.AppView = (app) ->

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