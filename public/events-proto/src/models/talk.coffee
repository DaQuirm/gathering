{Slot} = EventsProto.models

class Talk extends Slot

	constructor: ->
		super

		@duration = new nx.Cell
		@content.bind @duration, '<->', nx.Mapping 'duration':'_'

		@topic = new nx.Cell
		@content.bind @topic, '<->', nx.Mapping 'topic':'_'

		# @authors = new nx.Collection
		# @authors.bind @content, '<->', nx.Mapping '_':'authors'

		@type.value = Slot.types.TALK

EventsProto.models.Talk = Talk
