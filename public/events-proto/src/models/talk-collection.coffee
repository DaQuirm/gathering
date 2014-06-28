
class TalkCollection extends nx.RestCollection
	constructor: ->
		super
			url: '/talks'
			item: EventsProto.model.Talk

EventsProto.models.TalkCollection = TalkCollection
