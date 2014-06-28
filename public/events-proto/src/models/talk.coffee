class Talk extends nx.RestDocument
	constructor: (options) ->
		super
			url: '/talk/{_id}'

		@duration = new nx.Cell
		@data.bind @duration, '<->', new nx.Mapping 'duration':'_'

		@topic = new nx.Cell
		@data.bind @topic, '<->', new nx.Mapping 'topic':'_'

		@authors = new nx.Collection
		@data.bind @authors, '<->', new nx.Mapping 'authors':'_'

EventsProto.models.Talk = Talk
