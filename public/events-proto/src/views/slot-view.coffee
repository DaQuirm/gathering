EventsProto.views.Slot = (slot) ->
	switch slot.type.value
		when 'break'
			nxt.Element 'div',
				nxt.Element 'p',
					nxt.Element 'span',
						nxt.Text 'Break for '
					nxt.Element 'span',
						nxt.Text slot.content.duration.value + 'minutes'
		when 'talk'
			nxt.Element 'div',
				nxt.Element 'p',
					nxt.Element 'span',
						nxt.Text 'Topic: '
					nxt.Element 'span',
						nxt.Text slot.content.topic.value
				nxt.Element 'p',
					nxt.Element 'span',
						nxt.Text 'Duration: '
					nxt.Element 'span',
						nxt.Text slot.content.duration.value
