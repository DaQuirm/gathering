Slot = EventsProto.models.Slot

class Break extends Slot
	constructor: ->
		super

		@type = Slot.types.BREAK

		@duration = new nx.Cell
		@content.bind @duration, '<->', new nx.Mapping 'duration':'_'

EventsProto.models.Break = Break
