Slot = EventsProto.models.Slot

class Talk extends Slot
	constructor: ->
		super

		@type = Slot.types.TALK

		@duration = new nx.Cell
		@content.bind @duration, '<->', new nx.Mapping 'duration':'_'

		@topic = new nx.Cell
		@content.bind @topic, '<->', new nx.Mapping 'topic':'_'

		@authors = new nx.Collection
		@content.bind @authors, '<->', new nx.Mapping 'authors':'_'

EventsProto.models.Talk = Talk
