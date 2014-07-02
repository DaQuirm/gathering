SlotView = EventsProto.views.Slot

EventsProto.views.Event = (event) ->

	date = event.start_date.value
	day = do date.getDate
	month = EventsProto.helpers.Monthes[do date.getMonth]
	nxt.Element 'div',
		nxt.Element 'p',
			nxt.Element 'span',
				nxt.Text "#{event.title.value} "
			nxt.Element 'span',
				nxt.Text "#{day} #{month}"
		nxt.Element 'p',
			nxt.Element 'span',
				nxt.Text 'Venue '
			nxt.Element 'span',
				nxt.Text event.venue.value
		nxt.Collection event.slots, (slot) ->
			SlotView slot
