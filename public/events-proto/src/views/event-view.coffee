SlotView = EventsProto.views.SlotView

EventsProto.views.Event = (event) ->

	date = event.start_date.value
	nxt.Element 'div',
		nxt.Element 'p',
			nxt.Element 'span',
				nxt.Text "#{event.title.value} "
			nxt.Element 'span',
				nxt.Text (moment date).format 'LL'
		nxt.Element 'p',
			nxt.Element 'span',
				nxt.Text 'Venue '
			nxt.Element 'span',
				nxt.Text event.venue.value
		nxt.Collection event.slots, (slot) ->
			SlotView slot
