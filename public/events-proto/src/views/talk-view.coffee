EventsProto.views.TalkView = (talk) ->
	nxt.Element 'div',
		nxt.Element 'span',
			nxt.Text talk.title.value
		nxt.Element 'span',
			nxt.Text talk.author.value
		nxt.Element 'span',
			nxt.Text talk.duration.value

