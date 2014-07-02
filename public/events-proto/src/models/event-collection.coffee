Event = EventsProto.models.Event

class EventCollection extends nx.RestCollection
	constructor: ->
		super
			url: '/events'
			item: Event

	# create: ->
	# 	super @new_item, (item) =>
	# 		first = @todos.items[0]
	# 		@todos.insertBefore first, item

EventsProto.models.EventCollection = EventCollection
