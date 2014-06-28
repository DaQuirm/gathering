class Event extends nx.RestDocument
	constructor: (options) ->
		super
			url: '/events/{_id}'

		@data.value = options?.data or {}

		@start_date = new nx.Property
		@data.bind @start_date, '<->', new nx.Mapping 'startDate':'_'

		@title = new nx.Property
		@data.bind @title, '<->', new nx.Mapping 'title':'_'

		@talks = new nx.Collection
		@talks.bind @data, (data) -> data.talks 

EventsProto.models.Event = Event
