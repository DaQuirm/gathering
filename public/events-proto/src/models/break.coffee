{Slot} = EventsProto.models

class Break extends Slot

	constructor: ->
		super
		@duration = new nx.Cell value:0
		@duration.bind @content, '<->', nx.Mapping '_':'duration'
		@type.value = Slot.types.BREAK

EventsProto.models.Break = Break
