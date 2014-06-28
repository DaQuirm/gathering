class Slot

	@types =
		TALK:  'talk'
		BREAK: 'break'

	constructor: (options) ->

		@type = new nx.Cell value:Slot.types.TALK
		@content = new nx.Cell

		@duration = new nx.Cell
		@data.bind @duration, '<->', new nx.Mapping 'duration':'_'

		@topic = new nx.Cell
		@data.bind @topic, '<->', new nx.Mapping 'topic':'_'

		@authors = new nx.Collection
		@data.bind @authors, '<->', new nx.Mapping 'authors':'_'

EventsProto.models.Slot = Slot
