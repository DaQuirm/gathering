
class Talk
	constructor: ->

		@duration = new nx.Cell
		@topic = new nx.Cell
		@authors = new nx.Collection

EventsProto.models.Talk = Talk
