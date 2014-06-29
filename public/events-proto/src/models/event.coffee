class Event extends nx.RestDocument
	constructor: (options) ->
		super
			url: '/events/{_id}'

		@data.value = options?.data or {}

		@start_date = new nx.Cell
		@data.bind @start_date, '<->', new nx.Mapping 'startDate':'_'

		@title = new nx.Cell
		@data.bind @title, '<->', new nx.Mapping 'title':'_'

		@venue = new nx.Cell
		@data.bind @venue, '<->', new nx.Mapping 'venue':'_'

		@slots = new nx.Collection
		@slots.bind @data, '<->', (data) -> data.slots

EventsProto.models.Event = Event
