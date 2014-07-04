EventsProto.views.SlotView = (slot) ->
	switch slot.type.value
		when 'break'
			nxt.Html "
				<div>
					<p>
						<span>Break for </span>#{slot.content.duration.value} minutes
					</p>
				</div>"
		when 'talk'
			nxt.Html "
				<div>
					<p>
						<span>Topic: <span>#{slot.content.topic.value}</span>
					</p>
					<p>
						<span>Duration: <span>#{slot.content.duration.value}</span>
					</p>
				</div>"
