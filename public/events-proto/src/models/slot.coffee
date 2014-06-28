class Slot

	@types =
		TALK:  'talk'
		BREAK: 'break'

	constructor: ->
		@type = null
		@content = new nx.Cell

EventsProto.models.Slot = Slot
