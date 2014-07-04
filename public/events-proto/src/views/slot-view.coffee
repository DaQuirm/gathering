{Slot} = EventsProto.models

EventsProto.views.SlotView = (slot) ->
	switch slot.type.value
		when Slot.types.BREAK
			nxt.Html "
				<div>
					<p>
						<span>Break for </span>#{slot.duration.value} minutes
					</p>
				</div>"
		when Slot.types.TALK
			nxt.Html "
				<div>
					<p>
						<span>Topic: <span>#{slot.topic.value}</span>
					</p>
					<p>
						<span>Duration: <span>#{slot.duration.value}</span>
					</p>
				</div>"
