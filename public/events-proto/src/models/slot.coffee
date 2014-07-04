Break = EventsProto.models.Break
Talk = EventsProto.models.Talk

class Slot

	@types =
		TALK:  'talk'
		BREAK: 'break'

	constructor: ->
		@type = new nx.Cell
		@content = new nx.Cell value:{}

EventsProto.models.Slot = Slot
